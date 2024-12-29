import gleam/erlang
import gleam/float
import gleam/int
import gleam/io
import humanise
import shine_tree.{type ShineTree}

fn min_max_sum(results: ShineTree(Int)) {
  let assert Ok(#(value, rest)) =
    results
    |> shine_tree.shift

  let median_index = shine_tree.size(results) / 2
  use #(min_val, max_val, sum_val, median, index), actual_val <- shine_tree.fold_l(
    rest,
    #(value, value, value, 0, 0),
  )
  #(
    int.min(min_val, actual_val),
    int.max(max_val, actual_val),
    int.add(sum_val, actual_val),
    case index == median_index {
      True -> actual_val
      False -> median
    },
    index + 1,
  )
}

pub type BenchResults {
  BenchResults(
    name: String,
    count: Int,
    // times: ShineTree(Int),
    min: Int,
    max: Int,
    mean: Float,
    median: Int,
    std_deviation: Float,
  )
}

fn std_deviation_from(values: ShineTree(Int), mean: Float) -> Float {
  let assert Ok(result) =
    {
      use sum, val <- shine_tree.fold_l(values, 0.0)
      let assert Ok(val) =
        val
        |> int.to_float
        |> float.subtract(mean)
        |> float.power(2.0)
      sum +. val
    }
    |> float.divide(shine_tree.size(values) |> int.to_float)

  let assert Ok(result) =
    result
    |> float.square_root

  result
}

pub fn bench(
  results results: ShineTree(BenchResults),
  name name: String,
  warmup warmup: Int,
  duration duration: Int,
  values values: List(#(String, data)),
  f f: fn(data) -> u,
) {
  io.println_error("Starting benchmark: " <> name)
  // for each value in values, run a benchmark
  use tree, #(data_name, data) <- shine_tree.fold_l(
    values |> shine_tree.from_list,
    results,
  )

  io.println_error("  -> Warmup: " <> data_name)
  let now = erlang.system_time(erlang.Millisecond)
  use _warmup_samples <- do_samples_for(shine_tree.empty, now + warmup, data, f)
  io.println_error("  -> Running: " <> data_name)
  use actual_samples <- do_samples_for(
    shine_tree.empty,
    now + duration,
    data,
    f,
  )
  let #(min_val, max_val, sum_val, median_val, _) = min_max_sum(actual_samples)
  io.println_error("  -> Finished: " <> data_name)
  let mean =
    int.to_float(sum_val) /. int.to_float(shine_tree.size(actual_samples))

  tree
  |> shine_tree.push(BenchResults(
    name: name <> " -> " <> data_name,
    count: shine_tree.size(actual_samples),
    // times: actual_samples,
    mean: mean,
    max: max_val,
    min: min_val,
    median: median_val,
    std_deviation: std_deviation_from(actual_samples, mean),
  ))
}

fn do_samples_for(
  results: ShineTree(Int),
  until: Int,
  data: data,
  f: fn(data) -> u,
  next: fn(ShineTree(Int)) -> ShineTree(BenchResults),
) {
  case erlang.system_time(erlang.Millisecond) {
    now if now < until -> {
      let now = erlang.system_time(erlang.Microsecond)
      let _ = f(data)
      let end = erlang.system_time(erlang.Microsecond)

      do_samples_for(
        results
          |> shine_tree.push(end - now),
        until,
        data,
        f,
        next,
      )
    }
    _ -> next(results)
  }
}

fn force_unwrap(n: Result(Float, b)) {
  let assert Ok(n) = n
  n
}

pub fn format_bench(results: ShineTree(BenchResults)) {
  {
    use builder, results <- shine_tree.fold_l(
      results,
      "\n"
        <> "| Name | Mean | Median | Std. | Min | Max | Iterations |\n"
        <> "|---|---|---|---|---|---|---|\n",
    )
    builder
    <> "|"
    <> results.name
    <> "|"
    <> humanise.microseconds_float(results.mean)
    <> "|"
    <> humanise.microseconds_int(results.median)
    <> "|"
    <> results.std_deviation
    |> float.multiply(100.0)
    |> float.round
    |> int.to_float
    |> float.divide(100.0)
    |> force_unwrap
    |> float.to_string
    <> "|"
    <> humanise.microseconds_int(results.min)
    <> "|"
    <> humanise.microseconds_int(results.max)
    <> "|"
    <> int.to_string(results.count)
    <> "|\n"
  }
  <> "\n\n"
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
