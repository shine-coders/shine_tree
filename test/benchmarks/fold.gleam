import benchmarks/common.{Data, bench, format_bench}
import gleam/int
import gleam/io
import gleam/iterator
import gleam/list
import shine_tree

fn folding_operations() {
  []
  |> bench(
    name: "list.fold",
    config: [
      Data([
        #("n = 100", list.range(1, 100)),
        #("n = 1_000", list.range(1, 1000)),
        #("n = 10_000", list.range(1, 10_000)),
        #("n = 100_000", list.range(1, 100_000)),
      ]),
    ],
    f: list.fold(_, 0, int.add),
  )
  |> bench(
    name: "list.fold_right",
    config: [
      Data([
        #("n = 100", list.range(1, 100)),
        #("n = 1_000", list.range(1, 1000)),
        #("n = 10_000", list.range(1, 10_000)),
        #("n = 100_000", list.range(1, 100_000)),
      ]),
    ],
    f: list.fold_right(_, 0, int.add),
  )
  |> bench(
    name: "iterator.fold",
    config: [
      Data([
        #("n = 100", iterator.range(1, 100)),
        #("n = 1_000", iterator.range(1, 1000)),
        #("n = 10_000", iterator.range(1, 10_000)),
        #("n = 100_000", iterator.range(1, 100_000)),
      ]),
    ],
    f: iterator.fold(_, 0, int.add),
  )
  |> bench(
    name: "shine_tree.fold_l",
    config: [
      Data([
        #("n = 100", shine_tree.range(1, 100)),
        #("n = 1_000", shine_tree.range(1, 1000)),
        #("n = 10_000", shine_tree.range(1, 10_000)),
        #("n = 100_000", shine_tree.range(1, 100_000)),
      ]),
    ],
    f: shine_tree.fold_l(_, 0, int.add),
  )
  |> bench(
    name: "shine_tree.fold_r",
    config: [
      Data([
        #("n = 100", shine_tree.range(1, 100)),
        #("n = 1_000", shine_tree.range(1, 1000)),
        #("n = 10_000", shine_tree.range(1, 10_000)),
        #("n = 100_000", shine_tree.range(1, 100_000)),
      ]),
    ],
    f: shine_tree.fold_r(_, 0, int.add),
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  folding_operations()
}
