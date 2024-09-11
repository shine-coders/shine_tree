import benchmarks/common.{bench, format_bench}
import gleam/io
import gleam/list
import shine_tree

fn list_append_operations() {
  shine_tree.empty
  |> bench(
    name: "list.append",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", list.range(1, 100)),
      #("n = 1_000", list.range(1, 1000)),
      #("n = 10_000", list.range(1, 10_000)),
      #("n = 100_000", list.range(1, 100_000)),
    ],
    f: fn(val) { list.append(val, val) },
  )
  |> bench(
    name: "shine_tree.append",
    warmup: 3000,
    duration: 8000,
    values: [
      #("n = 100", shine_tree.range(1, 100)),
      #("n = 1_000", shine_tree.range(1, 1000)),
      #("n = 10_000", shine_tree.range(1, 10_000)),
      #("n = 100_000", shine_tree.range(1, 100_000)),
    ],
    f: fn(val) { shine_tree.append(val, val) },
  )
  |> format_bench("Appending Trees/lists")
  |> io.println
}

pub fn main() {
  list_append_operations()
}
