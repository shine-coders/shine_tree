import benchmarks/common
import gleam/int
import gleam/io
import gleam/list
import shine_tree

fn counting_operations() {
  shine_tree.empty
  |> common.bench(
    name: "List count evens",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", list.range(1, 100)),
      #("n = 1_000", list.range(1, 1000)),
      #("n = 10_000", list.range(1, 10_000)),
      #("n = 100_000", list.range(1, 100_000)),
    ],
    f: list.count(_, int.is_even),
  )
  |> common.bench(
    name: "ShineTree count evens",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", shine_tree.range(1, 100)),
      #("n = 1_000", shine_tree.range(1, 1000)),
      #("n = 10_000", shine_tree.range(1, 10_000)),
      #("n = 100_000", shine_tree.range(1, 100_000)),
    ],
    f: shine_tree.count(_, int.is_even),
  )
  |> common.format_bench("Element counting")
  |> io.println
}

pub fn main() {
  counting_operations()
}
