import benchmarks/common.{Data, bench, format_bench}
import gleam/io
import gleam/iterator
import gleam/list
import random_items
import shine_tree

fn get_group(n: Int) {
  n % 7
}

fn grouping_operations() {
  []
  |> bench(
    name: "list.group (n % 7)",
    config: [
      Data([
        #("n = 100", random_items.items_100),
        #("n = 1_000", random_items.items_1_000),
        #("n = 10_000", random_items.items_10_000),
        #("n = 100_000", random_items.items_100_000),
      ]),
    ],
    f: list.group(_, get_group),
  )
  |> bench(
    name: "iterator.group (n % 7)",
    config: [
      Data([
        #("n = 100", iterator.from_list(random_items.items_100)),
        #("n = 1_000", iterator.from_list(random_items.items_1_000)),
        #("n = 10_000", iterator.from_list(random_items.items_10_000)),
        #("n = 100_000", iterator.from_list(random_items.items_100_000)),
      ]),
    ],
    f: iterator.group(_, get_group),
  )
  |> bench(
    name: "shine_tree.group (n % 7)",
    config: [
      Data([
        #("n = 100", shine_tree.from_list(random_items.items_100)),
        #("n = 1_000", shine_tree.from_list(random_items.items_1_000)),
        #("n = 10_000", shine_tree.from_list(random_items.items_10_000)),
        #("n = 100_000", shine_tree.from_list(random_items.items_100_000)),
      ]),
    ],
    f: shine_tree.group(_, get_group),
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  grouping_operations()
}
