import benchmarks/common
import gleam/io
import gleam/list
import shine_tree

fn shifting_operations() {
  shine_tree.empty
  |> common.bench(
    name: "list (take one item at a time, until empty)",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", list.range(1, 100)),
      #("n = 1_000", list.range(1, 1000)),
      #("n = 10_000", list.range(1, 10_000)),
      #("n = 100_000", list.range(1, 100_000)),
    ],
    f: common.take_until_empty,
  )
  |> common.bench(
    name: "shine_tree.shift (against best case scenario list)",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", shine_tree.range(1, 100)),
      #("n = 1_000", shine_tree.range(1, 1000)),
      #("n = 10_000", shine_tree.range(1, 10_000)),
      #("n = 100_000", shine_tree.range(1, 100_000)),
    ],
    f: common.shine_tree_shift_until_empty,
  )
  |> common.bench(
    name: "shine_tree.pop (lists can't do this at all)",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", shine_tree.range(1, 100)),
      #("n = 1_000", shine_tree.range(1, 1000)),
      #("n = 10_000", shine_tree.range(1, 10_000)),
      #("n = 100_000", shine_tree.range(1, 100_000)),
    ],
    f: common.shine_tree_pop_until_empty,
  )
  |> common.format_bench
  |> io.println
}

pub fn main() {
  shifting_operations()
}
