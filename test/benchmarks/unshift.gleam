import benchmarks/common.{Data, bench, format_bench}
import gleam/io
import shine_tree

fn unshifting_operations() {
  []
  // Benchmark: unshift
  |> common.bench(
    name: "shine_tree.unshift(Nil)",
    config: [
      Data([
        #("n = 100", 100),
        #("n = 1_000", 1000),
        #("n = 10_000", 10_000),
        #("n = 100_000", 100_000),
      ]),
    ],
    f: common.unshift_shine_tree_nil(shine_tree.empty, _),
  )
  |> bench(
    name: "[item, ..rest]",
    config: [
      Data([
        #("n = 100", 100),
        #("n = 1_000", 1000),
        #("n = 10_000", 10_000),
        #("n = 100_000", 100_000),
      ]),
    ],
    f: common.prepend_list_nil([], _),
  )
  |> bench(
    name: "shine_tree.push(Nil) (lists can't do this at all)",
    config: [
      Data([
        #("n = 100", 100),
        #("n = 1_000", 1000),
        #("n = 10_000", 10_000),
        #("n = 100_000", 100_000),
      ]),
    ],
    f: common.push_shine_tree_nil(shine_tree.empty, _),
  )
  |> format_bench
  |> io.println
}

pub fn main() {
  unshifting_operations()
}
