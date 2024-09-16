import benchmarks/common.{Data, bench, format_bench}
import gleam/io
import gleam/iterator
import shine_tree

fn from_iterator_operations() {
  []
  |> bench(
    name: "iterator.to_list",
    config: [
      Data([
        #("n = 100", iterator.range(1, 100)),
        #("n = 1_000", iterator.range(1, 1000)),
        #("n = 10_000", iterator.range(1, 10_000)),
        #("n = 100_000", iterator.range(1, 100_000)),
      ]),
    ],
    f: iterator.to_list,
  )
  |> bench(
    name: "shine_tree.from_iterator",
    config: [
      Data([
        #("n = 100", iterator.range(1, 100)),
        #("n = 1_000", iterator.range(1, 1000)),
        #("n = 10_000", iterator.range(1, 10_000)),
        #("n = 100_000", iterator.range(1, 100_000)),
      ]),
    ],
    f: shine_tree.from_iterator,
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  from_iterator_operations()
}
