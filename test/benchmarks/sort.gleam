import benchmarks/common
import gleam/int
import gleam/io
import gleam/list
import random_items
import shine_tree

fn sorting_operations() {
  shine_tree.empty
  |> common.bench(
    name: "List sort",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", random_items.items_100),
      #("n = 1_000", random_items.items_1_000),
      #("n = 10_000", random_items.items_10_000),
      #("n = 100_000", random_items.items_100_000),
    ],
    f: list.sort(_, int.compare),
  )
  |> common.bench(
    name: "ShineTree sort",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", shine_tree.from_list(random_items.items_100)),
      #("n = 1_000", shine_tree.from_list(random_items.items_1_000)),
      #("n = 10_000", shine_tree.from_list(random_items.items_10_000)),
      #("n = 100_000", shine_tree.from_list(random_items.items_100_000)),
    ],
    f: shine_tree.quick_sort(_, int.compare),
  )
  |> common.format_bench("Sorting lists")
  |> io.println
}

pub fn main() {
  sorting_operations()
}
