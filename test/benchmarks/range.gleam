import benchmarks/common
import gleam/io
import gleam/list
import shine_tree

fn range_operations() {
  shine_tree.empty
  |> common.bench(
    name: "List range of size n",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", 100),
      #("n = 1_000", 1000),
      #("n = 10_000", 10_000),
      #("n = 100_000", 100_000),
    ],
    f: list.range(1, _),
  )
  |> common.bench(
    name: "ShineTree range of size n",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", 100),
      #("n = 1_000", 1000),
      #("n = 10_000", 10_000),
      #("n = 100_000", 100_000),
    ],
    f: shine_tree.range(1, _),
  )
  |> common.format_bench
  |> io.println
}

pub fn main() {
  range_operations()
}
