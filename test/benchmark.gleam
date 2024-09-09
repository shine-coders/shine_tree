import gleam/int
import gleam/iterator.{type Iterator}
import gleam/list
import glychee/benchmark.{Data, Function, run}
import glychee/configuration
import shine_tree.{type ShineTree}

pub fn main() {
  // Configuration is optional
  configuration.initialize()
  configuration.set_pair(configuration.Warmup, 2)
  configuration.set_pair(configuration.Parallel, 2)
  run(
    [
      Function("list.reduce(data)", fn(test_data: #(List(Int), ShineTree(Int))) {
        fn() { list.fold(test_data.0, 0, int.add) }
      }),
      Function("shine_tree.reduce", fn(test_data: #(List(Int), ShineTree(Int))) {
        fn() { shine_tree.fold_l(test_data.1, 0, int.add) }
      }),
    ],
    [
      Data("Reduce 100 items", #(list.range(1, 100), shine_tree.range(1, 100))),
      Data("Reduce 10_000 items", #(
        list.range(1, 10_000),
        shine_tree.range(1, 10_000),
      )),
      Data("Reduce 1_000_000 items", #(
        list.range(1, 1_000_000),
        shine_tree.range(1, 1_000_000),
      )),
    ],
  )

  run(
    [
      Function("shine_tree.unshift(Nil) * n", fn(n) {
        fn() { unshift_shine_tree_nil(shine_tree.empty, n) }
      }),
      Function("[item, ..rest] * n", fn(n) { fn() { prepend_list_nil([], n) } }),
    ],
    [
      Data("100 prepends", 100),
      Data("10_000 prepends", 10_000),
      Data("1_000_000 prepends", 1_000_000),
    ],
  )

  run(
    [
      Function("shine_tree.from_iterator", fn(iterable: Iterator(Int)) {
        fn() {
          shine_tree.from_iterator(iterable)
          Nil
        }
      }),
      Function("iterator.to_list", fn(iterable: Iterator(Int)) {
        fn() {
          iterator.to_list(iterable)
          Nil
        }
      }),
    ],
    [
      Data("from iterator of size 100", iterator.range(0, 100)),
      Data("from iterator of size 10_000", iterator.range(0, 10_000)),
      Data("from iterator of size 1_000_000", iterator.range(0, 1_000_000)),
    ],
  )

  run(
    [
      Function("shine_tree.append(n)", fn(n: #(ShineTree(Int), List(Int))) {
        fn() {
          shine_tree.append(n.0, n.0)
          Nil
        }
      }),
      Function("list.append(n)", fn(n: #(ShineTree(Int), List(Int))) {
        fn() {
          list.append(n.1, n.1)
          Nil
        }
      }),
    ],
    [
      Data("append 100 items to 100 items", #(
        shine_tree.range(1, 100),
        list.range(1, 100),
      )),
      Data("append 10_000 items to 10_000 items", #(
        shine_tree.range(1, 10_000),
        list.range(1, 10_000),
      )),
      Data("append 1_000_000 items to 1_000_000 items", #(
        shine_tree.range(1, 1_000_000),
        list.range(1, 1_000_000),
      )),
    ],
  )

  run(
    [
      Function("shine_tree.size(n)", fn(n: #(ShineTree(Int), List(Int))) {
        fn() { shine_tree.size(n.0) }
      }),
      Function("list.length(n)", fn(n: #(ShineTree(Int), List(Int))) {
        fn() { list.length(n.1) }
      }),
    ],
    [
      Data("calculate size of 100 items", #(
        shine_tree.range(1, 100),
        list.range(1, 100),
      )),
      Data("calculate size of 10_000 items", #(
        shine_tree.range(1, 10_000),
        list.range(1, 10_000),
      )),
      Data("calculate size of 1_000_000 items", #(
        shine_tree.range(1, 1_000_000),
        list.range(1, 1_000_000),
      )),
    ],
  )

  run(
    [
      Function("shine_tree.range(1, n)", fn(n: Int) {
        fn() {
          shine_tree.range(1, n)
          Nil
        }
      }),
      Function("list.range(1, n)", fn(n: Int) {
        fn() {
          list.range(1, n)
          Nil
        }
      }),
    ],
    [
      Data("create range of 100 items", 100),
      Data("create range of 10_000 items", 10_000),
      Data("create range of 1_000_000 items", 1_000_000),
    ],
  )
}

fn unshift_shine_tree_nil(tree: ShineTree(Nil), count: Int) {
  case count {
    0 -> Nil
    count -> unshift_shine_tree_nil(tree |> shine_tree.unshift(Nil), count - 1)
  }
}

fn prepend_list_nil(tree: List(Nil), count: Int) {
  case count {
    0 -> Nil
    count -> prepend_list_nil([Nil, ..tree], count - 1)
  }
}
