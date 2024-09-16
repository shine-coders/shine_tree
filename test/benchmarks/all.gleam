import benchmarks/common.{Data, bench, format_bench}
import gleam/io
import gleam/list
import shine_tree

fn all_operations() {
  let gt_0 = fn(a: Int) { a > 0 }
  []
  |> bench(
    name: "list.all",
    config: [
      Data([
        #("n = 100", list.range(1, 100)),
        #("n = 1_000", list.range(1, 1000)),
        #("n = 10_000", list.range(1, 10_000)),
        #("n = 100_000", list.range(1, 100_000)),
      ]),
    ],
    f: list.all(_, gt_0),
  )
  |> bench(
    name: "shine_tree.all",
    config: [
      Data([
        #("n = 100", shine_tree.range(1, 100)),
        #("n = 1_000", shine_tree.range(1, 1000)),
        #("n = 10_000", shine_tree.range(1, 10_000)),
        #("n = 100_000", shine_tree.range(1, 100_000)),
      ]),
    ],
    f: shine_tree.all(_, gt_0),
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  all_operations()
}
