import benchmarks/common.{Data, bench, format_bench}
import gleam/int
import gleam/io
import gleam/list
import shine_tree

fn counting_operations() {
  []
  |> bench(
    name: "List count evens",
    config: [
      Data([
        #("n = 100", list.range(1, 100)),
        #("n = 1_000", list.range(1, 1000)),
        #("n = 10_000", list.range(1, 10_000)),
        #("n = 100_000", list.range(1, 100_000)),
      ]),
    ],
    f: list.count(_, int.is_even),
  )
  |> bench(
    name: "ShineTree count evens",
    config: [
      Data([
        #("n = 100", shine_tree.range(1, 100)),
        #("n = 1_000", shine_tree.range(1, 1000)),
        #("n = 10_000", shine_tree.range(1, 10_000)),
        #("n = 100_000", shine_tree.range(1, 100_000)),
      ]),
    ],
    f: shine_tree.count(_, int.is_even),
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  counting_operations()
}
