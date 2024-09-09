import gleam/dict
import gleam/int
import gleam/io
import gleam/iterator
import gleam/list
import gleeunit
import gleeunit/should
import pprint
import shine_tree.{type ShineTree}

pub fn main() {
  gleeunit.main()
}

pub fn single_test() {
  let value = shine_tree.single(1)

  value
  |> shine_tree.size
  |> should.equal(1)

  value
  |> shine_tree.shift
  |> should.be_ok
  |> should.equal(#(1, shine_tree.empty))

  value
  |> shine_tree.pop
  |> should.be_ok
  |> should.equal(#(1, shine_tree.empty))
}

pub fn reduce_l_test() {
  let numbers = iterator.range(0, 1000)

  let sum_iterator =
    numbers
    |> iterator.reduce(int.add)
    |> should.be_ok

  let number_tree =
    numbers
    |> shine_tree.from_iterator

  number_tree
  |> shine_tree.reduce_l(0, int.add)
  |> should.equal(sum_iterator)

  number_tree
  |> shine_tree.reduce_r(0, int.add)
  |> should.equal(sum_iterator)
}

pub fn push_pop_test() {
  let pushed = {
    use tree, node <- iterator.fold(iterator.range(1, 1000), shine_tree.empty)
    tree |> shine_tree.push(node)
  }

  do_push_pop(pushed, 1000)
}

fn do_push_pop(tree: ShineTree(Int), expected: Int) {
  case tree |> shine_tree.pop, expected {
    Ok(#(value, tree)), expected if value == expected ->
      do_push_pop(tree, expected - 1)
    Ok(a), _ -> {
      io.println(pprint.format(a))
      panic as "Push pop failed!"
    }
    Error(_), 0 -> Ok(Nil)
    a, b -> {
      io.println(pprint.format(#(a, b)))
      panic as "Push pop failed!"
    }
  }
}

pub fn iterator_test() {
  let value_iterator = iterator.range(1, 1000)
  let expected = value_iterator |> iterator.to_list

  let actual =
    shine_tree.from_iterator(value_iterator)
    |> shine_tree.to_list

  actual
  |> should.equal(expected)
}

pub fn list_test() {
  let value_iterator = iterator.range(1, 1000)
  let expected = value_iterator |> iterator.to_list

  let actual = shine_tree.from_list(expected) |> shine_tree.to_list

  actual
  |> should.equal(expected)
}

pub fn size_test() {
  iterator.range(1, 3000)
  |> shine_tree.from_iterator
  |> shine_tree.size
  |> should.equal(3000)
}

pub fn all_test() {
  let number_range = iterator.range(1, 99)
  number_range
  |> iterator.map(int.multiply(2, _))
  |> shine_tree.from_iterator
  |> shine_tree.all(int.is_even)
  |> should.be_true

  number_range
  |> iterator.map(int.add(1, _))
  |> shine_tree.from_iterator
  |> shine_tree.all(int.is_even)
  |> should.be_false
}

pub fn any_test() {
  let number_range = iterator.range(1, 99)
  number_range
  |> iterator.map(int.multiply(2, _))
  |> iterator.map(int.add(1, _))
  |> shine_tree.from_iterator
  |> shine_tree.any(int.is_even)
  |> should.be_false

  number_range
  |> shine_tree.from_iterator
  |> shine_tree.any(fn(n) { n == 99 })
  |> should.be_true
}

pub fn filter_test() {
  let number_range = iterator.range(1, 999)

  let even_list =
    iterator.filter(number_range, int.is_even)
    |> iterator.to_list

  shine_tree.from_iterator(number_range)
  |> shine_tree.filter(int.is_even)
  |> shine_tree.to_list
  |> should.equal(even_list)
}

fn square(a: Int) {
  a * a
}

pub fn map_test() {
  let numbers_list =
    iterator.range(1, 100)
    |> iterator.map(square)
    |> iterator.to_list

  iterator.range(1, 100)
  |> shine_tree.from_iterator
  |> shine_tree.map(square)
  |> shine_tree.to_list
  |> should.equal(numbers_list)
}

pub fn reverse_test() {
  let reversed_list =
    iterator.range(500, 1)
    |> iterator.to_list

  iterator.range(1, 500)
  |> shine_tree.from_iterator
  |> shine_tree.reverse
  |> shine_tree.to_list
  |> should.equal(reversed_list)
}

fn fold_until_tester(acc: Int, next: Int) {
  case next {
    next if next >= 500 -> list.Stop(acc)
    next -> list.Continue(acc + next)
  }
}

pub fn fold_until_test() {
  let numbers = iterator.range(0, 1000)
  let expected =
    numbers
    |> iterator.fold_until(0, fold_until_tester)

  numbers
  |> shine_tree.from_iterator
  |> shine_tree.fold_until(0, fold_until_tester)
  |> should.equal(expected)
}
