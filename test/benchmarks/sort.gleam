import benchmarks/common.{Data, bench, format_bench}
import gleam/int
import gleam/io
import gleam/list
import random_items
import shine_tree

fn sorting_operations() {
  []
  |> bench(
    name: "List sort",
    config: [
      Data([
        #("n = 100", random_items.items_100),
        #("n = 1_000", random_items.items_1_000),
        #("n = 10_000", random_items.items_10_000),
        #("n = 100_000", random_items.items_100_000),
      ]),
    ],
    f: list.sort(_, int.compare),
  )
  |> bench(
    name: "ShineTree sort",
    config: [
      Data([
        #("n = 100", shine_tree.from_list(random_items.items_100)),
        #("n = 1_000", shine_tree.from_list(random_items.items_1_000)),
        #("n = 10_000", shine_tree.from_list(random_items.items_10_000)),
        #("n = 100_000", shine_tree.from_list(random_items.items_100_000)),
      ]),
    ],
    f: shine_tree.sort(_, int.compare),
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  sorting_operations()
}
