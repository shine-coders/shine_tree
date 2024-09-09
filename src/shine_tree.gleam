import gleam/iterator.{type Iterator, Done, Next}
import gleam/list.{type ContinueOrStop, Continue, Stop}
import gleam/option.{type Option, None, Some}
import gleam/result.{map}
import pprint
import simplifile

pub opaque type ShineTree(u) {
  Empty
  Single(u)
  Deep(size: Int, pf: Node(u), root: ShineTree(Node(u)), sf: Node(u))
}

type Node(u) {
  One(u)
  Two(u, u)
  Three(u, u, u)
  Four(u, u, u, u)
}

pub fn reduce_l(tree: ShineTree(u), v, f: fn(v, u) -> v) -> v {
  case tree {
    Empty -> v
    Single(u) -> f(v, u)
    Deep(_, pf, root, sf) -> {
      v
      |> reduce_l_node(pf, f)
      |> reduce_l_root(root, f)
      |> reduce_l_node(sf, f)
    }
  }
}

fn reduce_l_node(v, node: Node(u), f: fn(v, u) -> v) -> v {
  case node {
    One(w) -> f(v, w)
    Two(w, x) ->
      v
      |> f(w)
      |> f(x)
    Three(w, x, y) ->
      v
      |> f(w)
      |> f(x)
      |> f(y)
    Four(w, x, y, z) ->
      v
      |> f(w)
      |> f(x)
      |> f(y)
      |> f(z)
  }
}

fn reduce_l_root(acc: v, root: ShineTree(Node(u)), f: fn(v, u) -> v) -> v {
  use acc, node <- reduce_l(root, acc)
  reduce_l_node(acc, node, f)
}

pub fn reduce_r(tree: ShineTree(u), v, f: fn(v, u) -> v) -> v {
  case tree {
    Empty -> v
    Single(u) -> f(v, u)
    Deep(_, pf, root, sf) -> {
      v
      |> reduce_r_node(sf, f)
      |> reduce_r_root(root, f)
      |> reduce_r_node(pf, f)
    }
  }
}

fn reduce_r_node(v, node: Node(u), f: fn(v, u) -> v) -> v {
  case node {
    One(w) -> f(v, w)
    Two(w, x) ->
      v
      |> f(x)
      |> f(w)
    Three(w, x, y) ->
      v
      |> f(y)
      |> f(x)
      |> f(w)
    Four(w, x, y, z) ->
      v
      |> f(z)
      |> f(y)
      |> f(x)
      |> f(w)
  }
}

fn reduce_r_root(acc: v, root: ShineTree(Node(u)), f: fn(v, u) -> v) -> v {
  use acc, node <- reduce_r(root, acc)
  reduce_r_node(acc, node, f)
}

pub fn map(tree: ShineTree(u), f: fn(u) -> v) -> ShineTree(v) {
  case tree {
    Empty -> Empty
    Single(u) -> Single(f(u))
    Deep(count, pf, root, sf) -> {
      let pf = map_node(pf, f)
      let root = map_root(root, f)
      let sf = map_node(sf, f)
      Deep(count, pf, root, sf)
    }
  }
}

fn map_node(node: Node(u), f: fn(u) -> v) -> Node(v) {
  case node {
    One(w) -> One(f(w))
    Two(w, x) -> Two(f(w), f(x))
    Three(w, x, y) -> Three(f(w), f(x), f(y))
    Four(w, x, y, z) -> Four(f(w), f(x), f(y), f(z))
  }
}

fn map_root(root: ShineTree(Node(u)), f: fn(u) -> v) -> ShineTree(Node(v)) {
  use node <- map(root)
  map_node(node, f)
}

pub fn push(tree: ShineTree(u), value: u) -> ShineTree(u) {
  case tree {
    Empty -> Single(value)
    Single(v) -> Deep(2, One(v), Empty, One(value))
    Deep(count, pf, root, One(v)) -> Deep(count + 1, pf, root, Two(v, value))
    Deep(count, pf, root, Two(v, w)) ->
      Deep(count + 1, pf, root, Three(v, w, value))
    Deep(count, pf, root, Three(v, w, x)) ->
      Deep(count + 1, pf, root, Four(v, w, x, value))
    Deep(count, pf, root, sf) ->
      Deep(count + 1, pf, push_rec(root, sf), One(value))
  }
}

pub fn push2(tree: ShineTree(u), a: u, b: u) {
  case tree {
    Empty -> Deep(2, One(a), Empty, One(b))
    Single(u) -> Deep(3, One(u), Empty, Two(a, b))
    Deep(count, pr, root, sf) ->
      Deep(count + 2, pr, root |> push(sf), Two(a, b))
  }
}

pub fn push3(tree: ShineTree(u), a: u, b: u, c: u) {
  case tree {
    Empty -> Deep(3, One(a), Empty, Two(b, c))
    Single(u) -> Deep(4, Two(u, a), Empty, Two(b, c))
    Deep(count, pr, root, sf) ->
      Deep(count + 3, pr, root |> push(sf), Three(a, b, c))
  }
}

pub fn push4(tree: ShineTree(u), a: u, b: u, c: u, d: u) {
  case tree {
    Empty -> Deep(3, Two(a, b), Empty, Two(c, d))
    Single(u) -> Deep(5, Three(u, a, b), Empty, Two(c, d))
    Deep(count, pr, root, sf) ->
      Deep(count + 4, pr, root |> push(sf), Four(a, b, c, d))
  }
}

fn push_rec(root: ShineTree(Node(u)), val: Node(u)) {
  push(root, val)
}

pub fn unshift(tree: ShineTree(u), value: u) -> ShineTree(u) {
  case tree {
    Empty -> Single(value)
    Single(v) -> Deep(2, One(value), Empty, One(v))
    Deep(count, One(v), root, sf) -> Deep(count + 1, Two(value, v), root, sf)
    Deep(count, Two(v, w), root, sf) ->
      Deep(count + 1, Three(value, v, w), root, sf)
    Deep(count, Three(v, w, x), root, sf) ->
      Deep(count + 1, Four(value, v, w, x), root, sf)
    Deep(count, pf, root, sf) ->
      Deep(count + 1, One(value), unshift_rec(root, pf), sf)
  }
}

fn unshift_rec(root: ShineTree(Node(u)), val: Node(u)) {
  push(root, val)
}

pub fn unshift2(tree: ShineTree(u), a: u, b: u) {
  case tree {
    Empty -> Deep(2, One(a), Empty, One(b))
    Single(u) -> Deep(3, Two(a, b), Empty, One(u))
    Deep(count, pf, root, sf) ->
      Deep(count + 2, Two(a, b), root |> unshift(pf), sf)
  }
}

pub fn unshift3(tree: ShineTree(u), a: u, b: u, c: u) {
  case tree {
    Empty -> Deep(3, Two(a, b), Empty, One(c))
    Single(u) -> Deep(4, Two(a, b), Empty, Two(c, u))
    Deep(count, pf, root, sf) ->
      Deep(count + 3, Three(a, b, c), root |> unshift(pf), sf)
  }
}

pub fn unshift4(tree: ShineTree(u), a: u, b: u, c: u, d: u) {
  case tree {
    Empty -> Deep(4, Two(a, b), Empty, Two(c, d))
    Single(u) -> Deep(5, Three(a, b, c), Empty, Two(d, u))
    Deep(count, pf, root, sf) ->
      Deep(count + 4, Four(a, b, c, d), root |> unshift(pf), sf)
  }
}

pub fn pop(tree: ShineTree(u)) -> Result(#(u, ShineTree(u)), Nil) {
  case tree {
    Empty -> Error(Nil)
    Single(u) -> Ok(#(u, Empty))
    Deep(_, One(v), Empty, One(u)) -> Ok(#(u, Single(v)))
    Deep(count, Two(v, w), Empty, One(u)) ->
      Ok(#(u, Deep(count - 1, One(v), Empty, One(w))))
    Deep(count, Three(v, w, x), Empty, One(u)) ->
      Ok(#(u, Deep(count - 1, Two(v, w), Empty, One(x))))
    Deep(count, Four(v, w, x, y), Empty, One(u)) ->
      Ok(#(u, Deep(count - 1, Two(v, w), Empty, Two(x, y))))
    Deep(count, pf, root, One(u)) -> {
      let assert Ok(#(sf, root)) = pop_root(root)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
    Deep(count, pf, root, sf) -> {
      let assert Ok(#(u, sf)) = pop_node(sf)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
  }
}

fn pop_root(root: ShineTree(Node(u))) {
  pop(root)
}

fn pop_node(node: Node(u)) {
  case node {
    Two(u, v) -> Ok(#(v, One(u)))
    Three(u, v, w) -> Ok(#(w, Two(u, v)))
    Four(u, v, w, x) -> Ok(#(x, Three(u, v, w)))
    _ -> Error(Nil)
  }
}

pub fn shift(tree: ShineTree(u)) -> Result(#(u, ShineTree(u)), Nil) {
  case tree {
    Empty -> Error(Nil)
    Single(u) -> Ok(#(u, Empty))
    Deep(_, One(u), Empty, One(v)) -> Ok(#(u, Single(v)))
    Deep(count, One(u), Empty, Two(v, w)) ->
      Ok(#(u, Deep(count - 1, One(v), Empty, One(w))))
    Deep(count, One(u), Empty, Three(v, w, x)) ->
      Ok(#(u, Deep(count - 1, Two(v, w), Empty, One(x))))
    Deep(count, One(u), Empty, Four(v, w, x, y)) ->
      Ok(#(u, Deep(count - 1, Two(v, w), Empty, Two(x, y))))
    Deep(count, One(u), root, sf) -> {
      let assert Ok(#(pf, root)) = shift_root(root)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
    Deep(count, pf, root, sf) -> {
      let assert Ok(#(u, sf)) = shift_node(sf)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
  }
}

fn shift_root(root: ShineTree(Node(u))) {
  shift(root)
}

fn shift_node(node: Node(u)) {
  case node {
    Two(u, v) -> Ok(#(u, One(v)))
    Three(u, v, w) -> Ok(#(u, Two(v, w)))
    Four(u, v, w, x) -> Ok(#(u, Three(v, w, x)))
    _ -> Error(Nil)
  }
}

pub fn unfold(tree: ShineTree(u)) {
  iterator.unfold(to_node_list(tree), do_unfold)
}

fn do_unfold(state: List(Node(u))) {
  case state {
    [] -> Done
    [One(u), ..rest] -> Next(u, rest)
    [Two(u, v), ..rest] -> Next(u, [One(v), ..rest])
    [Three(u, v, w), ..rest] -> Next(u, [Two(v, w), ..rest])
    [Four(u, v, w, x), ..rest] -> Next(u, [Three(v, w, x), ..rest])
  }
}

fn to_node_list(tree: ShineTree(u)) {
  case tree {
    Empty -> []
    Single(u) -> [One(u)]
    Deep(_, pf, root, sf) -> [pf, ..reduce_r(root, [sf], do_add_node)]
  }
}

fn do_add_node(acc: List(Node(u)), node: Node(u)) {
  [node, ..acc]
}

pub fn filter(tree: ShineTree(u), f: fn(u) -> Bool) {
  {
    use acc, u <- reduce_r(tree, [])
    case f(u) {
      True -> [u, ..acc]
      False -> acc
    }
  }
  |> from_list
}

pub fn to_list(tree: ShineTree(u)) {
  use acc, u <- reduce_r(tree, [])
  [u, ..acc]
}

pub fn from_list(values: List(u)) {
  do_from_list(values)
}

fn do_from_list(values: List(u)) -> ShineTree(u) {
  case values {
    [] -> Empty
    [a] -> Single(a)
    [a, b] -> Deep(2, One(a), Empty, One(b))
    [a, b, c] -> Deep(3, Two(a, b), Empty, One(c))
    [a, b, c, d] -> Deep(4, Two(a, b), Empty, Two(c, d))
    [a, b, c, d, e] -> Deep(5, Three(a, b, c), Empty, Two(d, e))
    [a, b, c, d, e, f] -> Deep(6, Three(a, b, c), Empty, Three(d, e, f))
    [a, b, c, d, e, f, g] -> Deep(7, Four(a, b, c, d), Empty, Three(e, f, g))
    [a, b, c, d, e, f, g, h] ->
      Deep(8, Four(a, b, c, d), Empty, Four(e, f, g, h))
    [a, b, c, d, e, f, g, h, i] ->
      Deep(9, Four(a, b, c, d), Single(One(e)), Four(f, g, h, i))
    [a, b, c, d, e, f, g, h, i, j] ->
      Deep(10, Four(a, b, c, d), Single(Two(e, f)), Four(g, h, i, j))
    [a, b, c, d, e, f, g, h, i, j, k] ->
      Deep(11, Four(a, b, c, d), Single(Three(e, f, g)), Four(h, i, j, k))
    [a, b, c, d, e, f, g, h, i, j, k, l] ->
      Deep(12, Four(a, b, c, d), Single(Four(e, f, g, h)), Four(i, j, k, l))
    [a, b, c, d, ..rest] -> {
      let #(tail, rest, count) = do_chunk_values(rest, [], 4)
      Deep(count, Four(a, b, c, d), do_from_list_reverse(rest), tail)
    }
  }
}

fn do_chunk_values(
  values: List(u),
  acc: List(Node(u)),
  count: Int,
) -> #(Node(u), List(Node(u)), Int) {
  case values {
    [] -> panic as "This is impossible!"
    [a] -> #(One(a), acc, count + 1)
    [a, b] -> #(Two(a, b), acc, count + 2)
    [a, b, c] -> #(Three(a, b, c), acc, count + 3)
    [a, b, c, d] -> #(Four(a, b, c, d), acc, count + 4)
    [a, b, c, d, ..rest] ->
      do_chunk_values(rest, [Four(a, b, c, d), ..acc], count + 4)
  }
}

fn do_from_list_reverse(value: List(u)) -> ShineTree(u) {
  case value {
    [] -> Empty
    [a] -> Single(a)
    [a, b] -> Deep(2, One(b), Empty, One(a))
    [a, b, c] -> Deep(3, Two(c, b), Empty, One(a))
    [a, b, c, d] -> Deep(4, Two(d, c), Empty, Two(b, a))
    [a, b, c, d, e] -> Deep(5, Three(e, d, c), Empty, Two(b, a))
    [a, b, c, d, e, f] -> Deep(6, Three(f, e, d), Empty, Three(c, b, a))
    [a, b, c, d, e, f, g] -> Deep(7, Four(g, f, e, d), Empty, Three(c, b, a))
    [a, b, c, d, e, f, g, h] ->
      Deep(8, Four(h, g, f, e), Empty, Four(d, c, b, a))
    [a, b, c, d, e, f, g, h, i] ->
      Deep(9, Four(i, h, g, f), Single(One(e)), Four(d, c, b, a))
    [a, b, c, d, e, f, g, h, i, j] ->
      Deep(10, Four(j, i, h, g), Single(Two(f, e)), Four(d, c, b, a))
    [a, b, c, d, e, f, g, h, i, j, k] ->
      Deep(11, Four(k, j, i, h), Single(Three(g, f, e)), Four(d, c, b, a))
    [a, b, c, d, e, f, g, h, i, j, k, l] ->
      Deep(12, Four(l, k, j, i), Single(Four(h, g, f, e)), Four(d, c, b, a))
    [a, b, c, d, ..rest] -> {
      let tail = Four(d, c, b, a)
      let #(head, nodes, count) = do_chunk_values_reverse(rest, [], 4)

      Deep(count, head, do_from_list(nodes), tail)
    }
  }
}

fn do_chunk_values_reverse(items: List(u), acc: List(Node(u)), count: Int) {
  case items {
    [] -> panic as "This is impossible!"
    [a] -> #(One(a), acc, count + 1)
    [a, b] -> #(Two(b, a), acc, count + 2)
    [a, b, c] -> #(Three(c, b, a), acc, count + 3)
    [a, b, c, d] -> #(Four(d, c, b, a), acc, count + 4)
    [a, b, c, d, ..rest] ->
      do_chunk_values_reverse(rest, [Four(d, c, b, a), ..acc], count + 4)
  }
}

pub fn main() {
  iterator.range(0, 1000)
  |> iterator.to_list
  |> from_list
  |> pprint.format
  |> simplifile.write("./test.txt", _)
}

pub fn from_iterator(iterable: Iterator(u)) -> ShineTree(u) {
  let node_iterator =
    iterator.sized_chunk(iterable, 4)
    |> iterator.map(to_node)

  case iterator.step(node_iterator) {
    Done -> Empty
    Next(One(a), node_iterator) -> do_from_iterator(Single(a), node_iterator)
    Next(Two(a, b), node_iterator) ->
      do_from_iterator(Deep(2, One(a), Empty, One(b)), node_iterator)
    Next(Three(a, b, c), node_iterator) ->
      do_from_iterator(Deep(3, Two(a, b), Empty, One(c)), node_iterator)
    Next(Four(a, b, c, d), node_iterator) ->
      do_from_iterator(Deep(4, Two(a, b), Empty, Two(c, d)), node_iterator)
  }
}

fn to_node(val: List(u)) {
  case val {
    [a] -> One(a)
    [a, b] -> Two(a, b)
    [a, b, c] -> Three(a, b, c)
    [a, b, c, d] -> Four(a, b, c, d)
    _ -> panic as "This is impossible!"
  }
}

fn push_node(tree: ShineTree(u), node: Node(u)) -> ShineTree(u) {
  case tree, node {
    Empty, One(a) -> Single(a)
    Empty, Two(a, b) -> Deep(2, One(a), Empty, One(b))
    Empty, Three(a, b, c) -> Deep(3, One(a), Empty, Two(b, c))
    Empty, Four(a, b, c, d) -> Deep(4, Two(a, b), Empty, Two(c, d))
    Single(node), One(a) -> Deep(2, One(node), Empty, One(a))
    Single(node), Two(a, b) -> Deep(3, Two(node, a), Empty, One(b))
    Single(node), Three(a, b, c) -> Deep(4, Two(node, a), Empty, Two(b, c))
    Single(node), Four(a, b, c, d) ->
      Deep(5, Three(node, a, b), Empty, Two(c, d))
    Deep(count, pr, body, sf), One(a) ->
      Deep(count + 1, pr, body |> push(sf), One(a))
    Deep(count, pr, body, sf), Two(a, b) ->
      Deep(count + 2, pr, body |> push(sf), Two(a, b))
    Deep(count, pr, body, sf), Three(a, b, c) ->
      Deep(count + 3, pr, body |> push(sf), Three(a, b, c))
    Deep(count, pr, body, sf), Four(a, b, c, d) ->
      Deep(count + 4, pr, body |> push(sf), Four(a, b, c, d))
  }
}

fn do_from_iterator(acc: ShineTree(u), rest: Iterator(Node(u))) -> ShineTree(u) {
  case iterator.step(rest) {
    Done -> acc
    Next(node, rest) -> do_from_iterator(acc |> push_node(node), rest)
  }
}

pub fn prepend(tree_1: ShineTree(u), tree_2: ShineTree(u)) {
  append(tree_2, tree_1)
}

pub fn append(tree_1: ShineTree(u), tree_2: ShineTree(u)) -> ShineTree(u) {
  case tree_1, tree_2 {
    t1, Empty -> t1
    Empty, t2 -> t2
    t1, Single(a) -> t1 |> push(a)
    Single(a), t2 -> t2 |> unshift(a)
    Deep(count1, pf1, root1, sf1), Deep(count2, pf2, root2, sf2) ->
      Deep(
        count1 + count2,
        pf1,
        root1 |> push(sf1) |> append_rec(root2 |> unshift(pf2)),
        sf2,
      )
  }
}

fn append_rec(tree_1: ShineTree(Node(u)), tree_2: ShineTree(Node(u))) {
  tree_1 |> append(tree_2)
}

pub fn concat(trees: List(ShineTree(u))) {
  case trees {
    [] -> Empty
    [a] -> a
    [a, ..rest] -> append(a, concat(rest))
  }
}

pub fn reverse(tree: ShineTree(u)) -> ShineTree(u) {
  case tree {
    Deep(count, pf, root, sf) ->
      Deep(count, sf |> reverse_node, root |> reverse_rec, pf |> reverse_node)
    tree -> tree
  }
}

fn reverse_rec(tree: ShineTree(Node(u))) {
  tree |> map(reverse_node) |> reverse
}

fn reverse_node(node: Node(u)) {
  case node {
    Two(a, b) -> Two(b, a)
    Three(a, b, c) -> Three(c, b, a)
    Four(a, b, c, d) -> Four(d, c, b, a)
    node -> node
  }
}

pub const empty = Empty

pub fn single(u) {
  Single(u)
}

pub fn size(tree: ShineTree(u)) {
  case tree {
    Empty -> 0
    Single(_) -> 1
    Deep(a, _, _, _) -> a
  }
}

pub fn all(tree: ShineTree(u), f: fn(u) -> Bool) {
  case tree {
    Empty -> True
    Single(u) -> f(u)
    Deep(_, pf, root, sf) ->
      case all_node(pf, f), all_node(sf, f) {
        True, True -> all_rec(root, all_node(_, f))
        _, _ -> False
      }
  }
}

fn all_rec(tree: ShineTree(u), f: fn(u) -> Bool) {
  all(tree, f)
}

fn all_node(node: Node(u), f: fn(u) -> Bool) {
  case node {
    One(a) -> f(a)
    Two(a, b) -> f(a) && f(b)
    Three(a, b, c) -> f(a) && f(b) && f(c)
    Four(a, b, c, d) -> f(a) && f(b) && f(c) && f(d)
  }
}

pub fn any(tree: ShineTree(u), f: fn(u) -> Bool) {
  case tree {
    Empty -> False
    Single(u) -> f(u)
    Deep(_, pf, root, sf) ->
      case any_node(pf, f), any_node(sf, f) {
        False, False -> any_rec(root, any_node(_, f))
        _, _ -> True
      }
  }
}

fn any_node(node: Node(u), f: fn(u) -> Bool) {
  case node {
    One(a) -> f(a)
    Two(a, b) -> f(a) || f(b)
    Three(a, b, c) -> f(a) || f(b) || f(c)
    Four(a, b, c, d) -> f(a) || f(b) || f(c) || f(d)
  }
}

fn any_rec(tree: ShineTree(u), f: fn(u) -> Bool) {
  any(tree, f)
}

pub fn contains(tree: ShineTree(u), u) {
  use v <- any(tree)
  v == u
}

pub fn count(tree: ShineTree(u), f: fn(u) -> Bool) {
  use acc, u <- reduce_l(tree, 0)
  case f(u) {
    True -> acc + 1
    False -> acc
  }
}

fn unwrap_fold_until(v: ContinueOrStop(v)) {
  case v {
    Stop(v) | Continue(v) -> v
  }
}

pub fn fold_until(tree: ShineTree(u), v, f: fn(v, u) -> ContinueOrStop(v)) -> v {
  do_fold_until(tree, v, f) |> unwrap_fold_until
}

fn do_fold_until(tree: ShineTree(u), v, f: fn(v, u) -> ContinueOrStop(v)) {
  case tree {
    Empty -> Stop(v)
    Single(u) -> f(v, u)
    Deep(_, pf, root, sf) -> {
      case do_fold_node_until(pf, v, f) {
        Continue(v) -> {
          let deep_fold = {
            use v, node <- do_fold_until_rec(root, v)
            do_fold_node_until(node, v, f)
          }
          case deep_fold {
            Continue(v) -> do_fold_node_until(sf, v, f)
            v -> v
          }
        }
        v -> v
      }
    }
  }
}

const do_fold_until_rec = do_fold_until

fn do_fold_node_until(node: Node(u), v, f: fn(v, u) -> ContinueOrStop(v)) {
  case node {
    One(a) -> f(v, a)
    Two(a, b) ->
      case f(v, a) {
        Continue(v) -> f(v, b)
        v -> v
      }
    Three(a, b, c) ->
      case f(v, a) {
        Continue(v) ->
          case f(v, b) {
            Continue(v) -> f(v, c)
            v -> v
          }
        v -> v
      }
    Four(a, b, c, d) ->
      case f(v, a) {
        Continue(v) ->
          case f(v, b) {
            Continue(v) ->
              case f(v, c) {
                Continue(v) -> f(v, d)
                v -> v
              }
            v -> v
          }
        v -> v
      }
  }
}
