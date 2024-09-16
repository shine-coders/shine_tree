import benchmarks/common.{Data, bench, format_bench}
import gleam/io
import gleam/list
import shine_tree

fn range_operations() {
  []
  |> bench(
    name: "List range of size n",
    config: [
      Data([
        #("n = 100", 100),
        #("n = 1_000", 1000),
        #("n = 10_000", 10_000),
        #("n = 100_000", 100_000),
      ]),
    ],
    f: list.range(1, _),
  )
  |> bench(
    name: "ShineTree range of size n",
    config: [
      Data([
        #("n = 100", 100),
        #("n = 1_000", 1000),
        #("n = 10_000", 10_000),
        #("n = 100_000", 100_000),
      ]),
    ],
    f: shine_tree.range(1, _),
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  range_operations()
}
