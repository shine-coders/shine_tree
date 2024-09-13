import benchmarks/common
import gleam/io
import gleam/list
import shine_tree

fn size_operations() {
  shine_tree.empty
  |> common.bench(
    name: "list.size",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", list.range(1, 100)),
      #("n = 1_000", list.range(1, 1000)),
      #("n = 10_000", list.range(1, 10_000)),
      #("n = 100_000", list.range(1, 100_000)),
    ],
    f: list.length,
  )
  |> common.bench(
    name: "shine_tree.size",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", shine_tree.range(1, 100)),
      #("n = 1_000", shine_tree.range(1, 1000)),
      #("n = 10_000", shine_tree.range(1, 10_000)),
      #("n = 100_000", shine_tree.range(1, 100_000)),
    ],
    f: shine_tree.size,
  )
  |> common.format_bench("Checking Size")
  |> io.println
}

pub fn main() {
  size_operations()
}
