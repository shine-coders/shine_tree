import benchmarks/common.{Data, bench, format_bench}
import gleam/io
import gleam/list
import shine_tree

fn shifting_operations() {
  []
  |> bench(
    name: "list (take one item at a time, until empty)",
    config: [
      Data([
        #("n = 100", list.range(1, 100)),
        #("n = 1_000", list.range(1, 1000)),
        #("n = 10_000", list.range(1, 10_000)),
        #("n = 100_000", list.range(1, 100_000)),
      ]),
    ],
    f: common.take_until_empty,
  )
  |> bench(
    name: "shine_tree.shift (against best case scenario list)",
    config: [
      Data([
        #("n = 100", shine_tree.range(1, 100)),
        #("n = 1_000", shine_tree.range(1, 1000)),
        #("n = 10_000", shine_tree.range(1, 10_000)),
        #("n = 100_000", shine_tree.range(1, 100_000)),
      ]),
    ],
    f: common.shine_tree_shift_until_empty,
  )
  |> bench(
    name: "shine_tree.pop (lists can't do this at all)",
    config: [
      Data([
        #("n = 100", shine_tree.range(1, 100)),
        #("n = 1_000", shine_tree.range(1, 1000)),
        #("n = 10_000", shine_tree.range(1, 10_000)),
        #("n = 100_000", shine_tree.range(1, 100_000)),
      ]),
    ],
    f: common.shine_tree_pop_until_empty,
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  shifting_operations()
}
