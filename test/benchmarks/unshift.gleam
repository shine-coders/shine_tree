import benchmarks/common
import gleam/io
import shine_tree

fn unshifting_operations() {
  shine_tree.empty
  // Benchmark: unshift
  |> common.bench(
    name: "shine_tree.unshift(Nil)",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", 100),
      #("n = 1_000", 1000),
      #("n = 10_000", 10_000),
      #("n = 100_000", 100_000),
    ],
    f: common.unshift_shine_tree_nil(shine_tree.empty, _),
  )
  |> common.bench(
    name: "[item, ..rest]",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", 100),
      #("n = 1_000", 1000),
      #("n = 10_000", 10_000),
      #("n = 100_000", 100_000),
    ],
    f: common.prepend_list_nil([], _),
  )
  |> common.bench(
    name: "shine_tree.push(Nil) (lists can't do this at all)",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", 100),
      #("n = 1_000", 1000),
      #("n = 10_000", 10_000),
      #("n = 100_000", 100_000),
    ],
    f: common.push_shine_tree_nil(shine_tree.empty, _),
  )
  |> common.format_bench
  |> io.println
}

pub fn main() {
  unshifting_operations()
}
