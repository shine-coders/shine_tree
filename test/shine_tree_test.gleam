import gleam/int
import gleam/io
import gleam/iterator
import gleam/list
import gleam/pair
import gleeunit
import gleeunit/should
import pprint
import random_items
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

pub fn fold_l_test() {
  let numbers = iterator.range(0, 1000)

  let sum_iterator =
    numbers
    |> iterator.reduce(int.add)
    |> should.be_ok

  let number_tree =
    numbers
    |> shine_tree.from_iterator

  number_tree
  |> shine_tree.fold_l(0, int.add)
  |> should.equal(sum_iterator)

  number_tree
  |> shine_tree.fold_r(0, int.add)
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
  let size_3000_iterator = iterator.range(1, 3000)

  size_3000_iterator
  |> shine_tree.from_iterator
  |> shine_tree.size
  |> should.equal(3000)

  size_3000_iterator
  |> iterator.to_list
  |> shine_tree.from_list
  |> shine_tree.size
  |> should.equal(3000)

  push_for(shine_tree.empty, 3000, Nil)
  |> shine_tree.size
  |> should.equal(3000)

  unshift_for(shine_tree.empty, 3000, Nil)
  |> shine_tree.size
  |> should.equal(3000)

  pop_for(
    size_3000_iterator
      |> shine_tree.from_iterator,
    3000,
  )
  |> should.equal(shine_tree.empty)

  shift_for(
    size_3000_iterator
      |> shine_tree.from_iterator,
    3000,
  )
  |> should.equal(shine_tree.empty)
}

fn pop_for(tree: shine_tree.ShineTree(u), count: Int) {
  case count {
    0 -> tree
    _ ->
      pop_for(
        tree
          |> shine_tree.pop
          |> should.be_ok
          |> pair.second,
        count - 1,
      )
  }
}

fn shift_for(tree: shine_tree.ShineTree(u), count: Int) {
  case count {
    0 -> tree
    _ -> {
      shift_for(
        tree
          |> shine_tree.shift
          |> should.be_ok
          |> pair.second,
        count - 1,
      )
    }
  }
}

fn unshift_for(tree: shine_tree.ShineTree(u), count: Int, u) {
  case count {
    0 -> tree
    _ -> unshift_for(tree |> shine_tree.unshift(u), count - 1, u)
  }
}

fn push_for(tree: shine_tree.ShineTree(u), count: Int, u) {
  case count {
    0 -> tree
    _ -> push_for(tree |> shine_tree.push(u), count - 1, u)
  }
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
    iterator.range(5000, 1)
    |> iterator.to_list

  iterator.range(1, 5000)
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
    |> iterator.to_list
    |> list.fold_until(0, fold_until_tester)

  numbers
  |> shine_tree.from_iterator
  |> shine_tree.fold_until(0, fold_until_tester)
  |> should.equal(expected)
}

pub fn range_test() {
  let numbers = list.range(0, 1000)
  let negative_numbers = list.range(0, -1000)

  shine_tree.range(0, 1000)
  |> shine_tree.to_list
  |> should.equal(numbers)

  shine_tree.range(0, -1000)
  |> shine_tree.to_list
  |> should.equal(negative_numbers)
}

pub fn sort_test() {
  let sorted =
    shine_tree.from_list(random_items.items_10_000)
    |> shine_tree.sort(int.compare)

  use left, right <- shine_tree.fold_l(sorted, 0)

  case left, right {
    left, right if left <= right -> right
    _, _ -> panic as "Sort failed!"
  }
}
