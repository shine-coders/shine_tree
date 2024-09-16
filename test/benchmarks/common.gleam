import gleam/erlang
import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/order.{Eq, Gt, Lt}
import gleam/string_builder
import shine_tree.{type ShineTree}

pub type Sample {
  Sample(
    start_time: Int,
    end_time: Int,
    iterations: Int,
    iterations_per_second: Float,
  )
}

pub type DataDefinition(
  u,
  // name/description
  // data value of type u
) =
  #(String, u)

pub type BenchConfigurationOption(u) {
  MaxIterations(count: Int)
  MinIterations(count: Int)
  MinDuration(time_ms: Int)
  MaxDuration(time_ms: Int)
  SampleCount(count: Int)
  Data(elements: List(DataDefinition(u)))
}

pub type BenchConfiguration(u) {
  BenchConfiguration(
    max_iter: Int,
    min_iter: Int,
    min_duration: Int,
    max_duration: Int,
    sample_count: Int,
    elements: List(DataDefinition(u)),
  )
}

const default_bench_config = BenchConfiguration(
  max_iter: 8000,
  min_iter: 500,
  min_duration: 2000,
  max_duration: 8000,
  sample_count: 30,
  elements: [],
)

fn fold_config_option(
  config: BenchConfiguration(u),
  option: BenchConfigurationOption(u),
) {
  case option {
    MaxIterations(count) -> BenchConfiguration(..config, max_iter: count)
    MinIterations(count) -> BenchConfiguration(..config, min_iter: count)
    MinDuration(time_ms) -> BenchConfiguration(..config, min_duration: time_ms)
    MaxDuration(time_ms) -> BenchConfiguration(..config, max_duration: time_ms)
    SampleCount(count) -> BenchConfiguration(..config, sample_count: count)
    Data(elements) -> BenchConfiguration(..config, elements: elements)
  }
}

pub type BenchResult {
  BenchResult(
    name: String,
    data_desc: String,
    samples: List(Sample),
    mean: Float,
    q1: Float,
    median: Float,
    q3: Float,
    min: Float,
    max: Float,
    variance: Float,
    std_dev: Float,
  )
}

fn mean(samples: List(Sample)) {
  do_mean(samples, 0.0, 0)
}

fn do_mean(samples: List(Sample), sum: Float, count: Int) {
  case samples {
    [] -> #(sum /. int.to_float(count), count)

    [sample, ..samples] -> {
      do_mean(samples, sum +. sample.iterations_per_second, count + 1)
    }
  }
}

fn sort_samples(sample_list: List(Sample)) {
  use a, b <- list.sort(sample_list)
  case a.iterations_per_second, b.iterations_per_second {
    a, b if a >. b -> Gt
    a, b if a <. b -> Lt
    _, _ -> Eq
  }
}

fn stats(samples: List(Sample), count: Int) {
  io.println_error(
    "  > Collecting Stats for " <> int.to_string(count) <> " samples...",
  )
  let q1_idx = { count + 1 } / 4
  let median_idx = { count + 1 } / 2
  let q3_idx = { count + 1 } * 3 / 4
  use acc, item <- list.fold(sort_samples(samples), #(
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0,
  ))
  let #(_, _, _, min, max, _) = acc
  let min = float.min(item.iterations_per_second, min)
  let max = float.min(item.iterations_per_second, max)
  case acc {
    #(_, b, c, _, _, idx) if idx == q1_idx -> #(
      item.iterations_per_second,
      b,
      c,
      min,
      max,
      idx + 1,
    )
    #(a, _, c, _, _, idx) if idx == median_idx -> #(
      a,
      item.iterations_per_second,
      c,
      min,
      max,
      idx + 1,
    )
    #(a, b, _, _, _, idx) if idx == q3_idx -> #(
      a,
      b,
      item.iterations_per_second,
      min,
      max,
      idx + 1,
    )
    #(a, b, c, _, _, idx) -> #(a, b, c, min, max, idx + 1)
  }
}

pub fn bench(
  benchmarks benchmarks: List(BenchResult),
  name name: String,
  config config_options: List(BenchConfigurationOption(data)),
  f f: fn(data) -> u,
) {
  io.println_error("Starting benchmark: " <> name)
  let config =
    list.fold(config_options, default_bench_config, fold_config_option)
  let BenchConfiguration(
    max_iter,
    min_iter,
    min_duration,
    max_duration,
    sample_count,
    elements,
  ) = config
  io.println_error("Using Configuration:")
  io.println_error("  > Min Iterations:  " <> int.to_string(min_iter))
  io.println_error("  > Max Iterations: " <> int.to_string(max_iter))
  io.println_error("  > Min Duration: " <> int.to_string(min_duration))
  io.println_error("  > Max Duration: " <> int.to_string(max_duration))
  io.println_error("  > Sample Count: " <> int.to_string(sample_count))

  // for each data element
  use benchmarks, #(data_desc, data) <- list.fold(elements, benchmarks)
  io.println_error("Performing benchmark using " <> data_desc)

  let samples = do_collect_samples(config, [], sample_count, f, data)

  // collect the statistics
  let #(mean, count) = mean(samples)
  let #(q1, median, q3, min, max, _) = stats(samples, count)
  let variance = variance(samples, count, mean)
  let std_dev = float.square_root(variance) |> force_unwrap

  let final_bench =
    BenchResult(
      name: name,
      data_desc: data_desc,
      samples: samples,
      mean: mean,
      q1: q1,
      median: median,
      q3: q3,
      min: min,
      max: max,
      variance: variance,
      std_dev: std_dev,
    )
  [final_bench, ..benchmarks]
}

fn now_ms() {
  erlang.system_time(erlang.Millisecond)
}

fn do_collect_samples(
  config: BenchConfiguration(data),
  acc: List(Sample),
  samples_left: Int,
  f: fn(data) -> u,
  data,
) {
  case samples_left {
    0 -> acc
    _ -> {
      io.print_error(".")
      do_collect_samples(
        config,
        [do_collect_sample(config, f, data, now_ms(), 0), ..acc],
        samples_left - 1,
        f,
        data,
      )
    }
  }
}

fn do_collect_sample(
  config: BenchConfiguration(data),
  f: fn(data) -> u,
  data,
  start: Int,
  count: Int,
) {
  let now = now_ms()
  let elapsed_duration = now - start
  let min_reached = count >= config.min_iter
  let max_reached = count >= config.max_iter
  let crossed_min_duration = elapsed_duration >= config.min_duration
  let crossed_max_duration = elapsed_duration >= config.max_duration

  case min_reached, crossed_min_duration, max_reached, crossed_max_duration {
    True, _, _, True | _, True, True, _ -> {
      Sample(
        start_time: start,
        end_time: now,
        iterations: count,
        iterations_per_second: int.to_float(count)
          /. int.to_float(elapsed_duration)
          /. 1000.0,
      )
    }
    _, _, _, _ -> {
      call_n_times(f, data, 100)
      do_collect_sample(config, f, data, start, count + 100)
    }
  }
}

fn call_n_times(f: fn(data) -> u, data, n) {
  let _ = f(data)
  case n {
    0 -> Nil
    _ -> call_n_times(f, data, n - 1)
  }
}

fn variance(samples: List(Sample), count: Int, mean: Float) {
  {
    use sum, sample <- list.fold(samples, 0.0)
    sample.iterations_per_second
    |> float.subtract(mean)
    |> float.power(2.0)
    |> force_unwrap
    |> float.add(sum)
  }
  |> float.divide(int.to_float(count))
  |> force_unwrap
}

fn force_unwrap(n: Result(Float, b)) {
  let assert Ok(n) = n
  n
}

fn format_float(value: Float) {
  float.to_string(int.to_float(float.round(value *. 100.0)) /. 100.0)
}

pub fn format_bench(results: List(BenchResult)) {
  let builder =
    string_builder.new()
    |> string_builder.append("\n")
    |> string_builder.append(
      "All statistics are reported in Iterations per second\n\n",
    )
    |> string_builder.append(
      "| Name | Samples | Mean | Min | Q1 | Median | Q3 | Max | STD |\n",
    )
    |> string_builder.append("|---|---|---|---|---|---|---|---|---|\n")
  {
    use builder, results <- list.fold(results, builder)

    builder
    |> string_builder.append("|")
    |> string_builder.append(results.name)
    |> string_builder.append(" - ")
    |> string_builder.append(results.data_desc)
    |> string_builder.append("|")
    |> string_builder.append(results.samples |> list.length |> int.to_string)
    |> string_builder.append("|")
    |> string_builder.append(format_float(results.mean))
    |> string_builder.append("|")
    |> string_builder.append(format_float(results.min))
    |> string_builder.append("|\n")
    |> string_builder.append(format_float(results.q1))
    |> string_builder.append("|")
    |> string_builder.append(format_float(results.median))
    |> string_builder.append("|")
    |> string_builder.append(format_float(results.q3))
    |> string_builder.append("|")
    |> string_builder.append(format_float(results.max))
    |> string_builder.append("|")
    |> string_builder.append(format_float(results.std_dev))
    |> string_builder.append("|")
  }
  |> string_builder.append("\n")
  |> string_builder.to_string
}

pub fn push_shine_tree_nil(tree: ShineTree(Nil), count: Int) {
  case count {
    0 -> Nil
    count -> push_shine_tree_nil(tree |> shine_tree.push(Nil), count - 1)
  }
}

pub fn unshift_shine_tree_nil(tree: ShineTree(Nil), count: Int) {
  case count {
    0 -> Nil
    count -> unshift_shine_tree_nil(tree |> shine_tree.unshift(Nil), count - 1)
  }
}

pub fn prepend_list_nil(tree: List(Nil), count: Int) {
  case count {
    0 -> Nil
    count -> prepend_list_nil([Nil, ..tree], count - 1)
  }
}

pub fn take_until_empty(items: List(Int)) {
  case items {
    [] -> Nil
    [_, ..rest] -> take_until_empty(rest)
  }
}

pub fn shine_tree_shift_until_empty(tree: ShineTree(Int)) {
  case shine_tree.shift(tree) {
    Error(_) -> Nil
    Ok(#(_, rest)) -> shine_tree_shift_until_empty(rest)
  }
}

pub fn shine_tree_pop_until_empty(tree: ShineTree(Int)) {
  case shine_tree.pop(tree) {
    Error(_) -> Nil
    Ok(#(_, rest)) -> shine_tree_pop_until_empty(rest)
  }
}
