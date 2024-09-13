import benchmarks/common
import gleam/io
import gleam/iterator
import shine_tree

fn from_iterator_operations() {
  shine_tree.empty
  |> common.bench(
    name: "iterator.to_list",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", iterator.range(1, 100)),
      #("n = 1_000", iterator.range(1, 1000)),
      #("n = 10_000", iterator.range(1, 10_000)),
      #("n = 100_000", iterator.range(1, 100_000)),
    ],
    f: iterator.to_list,
  )
  |> common.bench(
    name: "shine_tree.from_iterator",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", iterator.range(1, 100)),
      #("n = 1_000", iterator.range(1, 1000)),
      #("n = 10_000", iterator.range(1, 10_000)),
      #("n = 100_000", iterator.range(1, 100_000)),
    ],
    f: shine_tree.from_iterator,
  )
  |> common.format_bench
  |> io.println
}

pub fn main() {
  from_iterator_operations()
}
