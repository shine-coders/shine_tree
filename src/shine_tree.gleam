import gleam/dict.{type Dict}
import gleam/iterator.{type Iterator, Done, Next}
import gleam/list.{type ContinueOrStop, Continue, Stop}
import gleam/option.{None, Some}
import gleam/order.{type Order, Gt}
import gleam/result.{try}

/// An ordered tree of values used to implement other kinds of data
/// structures like queues. Elements can be added or removed from the
/// head or tail of the tree in nearly constant time.
pub opaque type ShineTree(u) {
  Empty
  Single(u)
  Deep(size: Int, pf: Node(u), root: ShineTree(Node(u)), sf: Node(u))
}

/// A collection of up to 4 items
type Node(u) {
  One(u)
  Two(u, u)
  Three(u, u, u)
  Four(u, u, u, u)
}

/// Reduces all the elements of the given tree into a single value,
/// made by calling a given function on all the elements, traversing
/// the tree from left to right.
///
/// `fold_l(shine_tree.from_list([1, 2, 3]), 0, int.add)` is the equivalent of
/// `add(add(add(0, 1), 2), 3)`.
///
/// ```gleam
/// // calculate 20! (factorial)
/// let n = 20
/// shine_tree.fold_l(shine_tree.range(2, n), int.multiply)
/// // -> 2432902008176640000
/// ```
pub fn fold_l(over tree: ShineTree(u), from v, with f: fn(v, u) -> v) -> v {
  case tree {
    Empty -> v
    Single(u) -> f(v, u)
    Deep(_, pf, root, sf) -> {
      v
      |> fold_l_node(pf, f)
      |> fold_l_root(root, f)
      |> fold_l_node(sf, f)
    }
  }
}

fn fold_l_node(v, node: Node(u), f: fn(v, u) -> v) -> v {
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

fn fold_l_root(acc: v, root: ShineTree(Node(u)), f: fn(v, u) -> v) -> v {
  use acc, node <- fold_l(root, acc)
  fold_l_node(acc, node, f)
}

/// This is an alias for `fold_l`.
pub const fold = fold_l

/// Reduces all the elements of the given tree into a single value,
/// made by calling a given function on all the elements, traversing
/// the tree from left to right.
///
/// `fold_r(shine_tree.from_list([1, 2, 3]), 0, int.add)` is the equivalent of
/// `add(add(add(0, 3), 2), 1)`.
///
/// ```gleam
/// // calculate 20! (factorial)
/// let n = 20
/// shine_tree.fold_r(shine_tree.range(2, n), int.multiply)
/// // -> 2432902008176640000
/// ```
pub fn fold_r(tree: ShineTree(u), v, f: fn(v, u) -> v) -> v {
  case tree {
    Empty -> v
    Single(u) -> f(v, u)
    Deep(_, pf, root, sf) -> {
      v
      |> fold_r_node(sf, f)
      |> fold_r_root(root, f)
      |> fold_r_node(pf, f)
    }
  }
}

fn fold_r_node(v, node: Node(u), f: fn(v, u) -> v) -> v {
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

fn fold_r_root(acc: v, root: ShineTree(Node(u)), f: fn(v, u) -> v) -> v {
  use acc, node <- fold_r(root, acc)
  fold_r_node(acc, node, f)
}

/// This is an alias for `fold_r`.
pub const fold_right = fold_r

/// Maps all the elements of the given tree into a new tree where
/// each element has been transformed by the given function.
/// 
/// ```gleam
/// let tree = shine_tree.from_list([1, 2, 3])
/// shine_tree.map(tree, int.multiply(2, _))
/// // -> shine_tree.from_list([2, 4, 6])
/// ```
pub fn map(tree: ShineTree(u), with f: fn(u) -> v) -> ShineTree(v) {
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

/// Pushes an element to the end of the given tree.
/// 
/// ```gleam
/// let tree = shine_tree.from_list([1, 2, 3])
/// shine_tree.push(tree, 4)
/// // -> shine_tree.from_list([1, 2, 3, 4])
/// ```
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

const push_rec = push

/// Pushes an element to the beginning of the given tree.
/// 
/// ```gleam
/// let tree = shine_tree.from_list([1, 2, 3])
/// shine_tree.unshift(tree, 0)
/// // -> shine_tree.from_list([0, 1, 2, 3])
/// ```
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

const unshift_rec = unshift

/// Pops an element from the end of the given tree.
/// 
/// If there are no items, it returns `Error(Nil)`, otherwise
/// it returns the popped item, and the resulting tree with the
/// element removed.
/// 
/// ```gleam
/// let tree = shine_tree.from_list([1, 2, 3])
/// shine_tree.pop(tree)
/// // -> Ok(3, shine_tree.from_list([1, 2]))
/// ```
/// 
/// ```gleam
/// shine_tree.empty |> shine_tree.pop
/// // -> Error(Nil)
/// ```
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
      let assert Ok(#(sf, root)) = pop_rec(root)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
    Deep(count, pf, root, sf) -> {
      let assert Ok(#(u, sf)) = pop_node(sf)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
  }
}

const pop_rec = pop

fn pop_node(node: Node(u)) {
  case node {
    Two(u, v) -> Ok(#(v, One(u)))
    Three(u, v, w) -> Ok(#(w, Two(u, v)))
    Four(u, v, w, x) -> Ok(#(x, Three(u, v, w)))
    _ -> Error(Nil)
  }
}

/// Pops an element from the front of the given tree.
/// 
/// If there are no items, it returns `Error(Nil)`, otherwise
/// it returns the popped item, and the resulting tree with the
/// element removed.
/// 
/// ```gleam
/// let tree = shine_tree.from_list([1, 2, 3])
/// shine_tree.shift(tree)
/// // -> Ok(1, shine_tree.from_list([2, 3]))
/// ```
/// 
/// ```gleam
/// shine_tree.empty |> shine_tree.pop
/// // -> Error(Nil)
/// ```
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
      let assert Ok(#(pf, root)) = shift_rec(root)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
    Deep(count, pf, root, sf) -> {
      let assert Ok(#(u, pf)) = shift_node(pf)
      Ok(#(u, Deep(count - 1, pf, root, sf)))
    }
  }
}

const shift_rec = shift

fn shift_node(node: Node(u)) {
  case node {
    Two(u, v) -> Ok(#(u, One(v)))
    Three(u, v, w) -> Ok(#(u, Two(v, w)))
    Four(u, v, w, x) -> Ok(#(u, Three(v, w, x)))
    _ -> Error(Nil)
  }
}

/// Creates an iterator from a given tree, yielding each element in succession until
/// there are no elements left.
///
/// ## Examples
///
/// ```gleam
/// let iter = unfold(shine_tree.from_list([1, 2, 3]))
/// 
/// let #(num, iter) = iterator.step(iter)
/// // -> Next(1, Iterator(Int))
/// let #(num, iter) = iterator.step(iter)
/// // -> Next(2, Iterator(Int))
/// let #(num, iter) = iterator.step(iter)
/// // -> Next(3, Iterator(Int))
/// let a = iterator.step(iter)
/// // -> Done
/// ```
///
pub fn to_iterator(tree: ShineTree(u)) {
  use state <- iterator.unfold(tree)
  case shift(state) {
    Ok(#(item, next)) -> Next(item, next)
    Error(Nil) -> Done
  }
}

/// Creates a new tree containing all the elements of the given tree,
/// for which the given predicate returns `True`.
/// 
/// ```gleam
/// shine_tree.from_list([1, 2, 3, 4, 5, 6, 7])
/// |> filter(int.is_odd)
/// // -> shine_tree.from_list([1, 3, 5, 7])
/// ```
/// 
pub fn filter(tree: ShineTree(u), f: fn(u) -> Bool) {
  {
    use acc, u <- fold_r(tree, [])
    case f(u) {
      True -> [u, ..acc]
      False -> acc
    }
  }
  |> do_from_list
}

/// Creates a new list containing all the elements of the given tree.
/// 
/// ```gleam
/// shine_tree.from_list([1, 2, 3, 4, 5, 6, 7])
/// |> to_list
/// // -> [1, 2, 3, 4, 5, 6, 7]
/// ```
/// 
pub fn to_list(tree: ShineTree(u)) {
  use acc, u <- fold_r(tree, [])
  [u, ..acc]
}

/// Creates a new tree containing all the elements of the given list.
/// 
/// ```gleam
/// shine_tree.from_list([1, 2, 3, 4, 5, 6, 7])
/// // -> It's a ShineTree with all the items in it!
/// // Were you expecting a list?
/// ```
/// 
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

/// Finds the first element in a given tree that satisfies the given predicate.
/// 
/// ```gleam
/// shine_tree.from_list([1, 2, 3, 4, 5, 6, 7])
/// |> find(int.is_even)
/// // -> 2
/// ```
/// 
pub fn find(tree: ShineTree(u), f: fn(u) -> Bool) {
  {
    use _, item <- fold_until(tree, None)
    case f(item) {
      True -> Stop(Some(item))
      False -> Continue(None)
    }
  }
  |> option.to_result(Nil)
}

/// Finds the first element in a given tree for which the given function returns `Ok(val)`.
/// 
/// ```gleam
/// shine_tree.from_list([1, 2, 3, 4, 5, 6, 7])
/// |> find_map(fn(u) {
///   case u > 5 {
///     True -> Ok(u)
///     False -> Error(Nil)
///   }
/// })
/// // -> 2
/// ```
/// 
pub fn find_map(tree: ShineTree(u), f: fn(u) -> Result(b, c)) {
  {
    use _, item <- fold_until(tree, None)
    case f(item) {
      Ok(val) -> Stop(Some(val))
      _ -> Continue(None)
    }
  }
  |> option.to_result(Nil)
}

fn do_chunk_values(
  values: List(u),
  acc: List(Node(u)),
  count: Int,
) -> #(Node(u), List(Node(u)), Int) {
  case values {
    [] -> panic as "This is impossible!"
    // this will NEVER happen
    [a] -> #(One(a), acc, count + 1)
    //1 
    [a, b] -> #(Two(a, b), acc, count + 2)
    //2
    [a, b, c] -> #(Three(a, b, c), acc, count + 3)
    //3 
    [a, b, c, d] -> #(Four(a, b, c, d), acc, count + 4)
    //4
    [a, b, c, d, ..rest] ->
      do_chunk_values(rest, [Four(a, b, c, d), ..acc], count + 4)
    // also 4, but recurse
    //                      ^^^^^^^^^^^^^^ We just prepended the value?
    // Yes. That means the first four items (as a node) (that we inserted) are at the END of the linked list
    // Got it :)
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

/// Returns the number of elements in the given tree.
/// 
/// This is an O(1) operation, because the size is cached in the tree
/// at the time it is created.
pub fn size(tree: ShineTree(u)) {
  case tree {
    Empty -> 0
    Single(_) -> 1
    Deep(a, _, _, _) -> a
  }
}

/// Returns `true` if the predicate `f` returns `True` for each
/// element in the ShineTree. Returns `False` otherwise.
/// 
/// ## Examples
///
/// ```gleam
/// shine_tree.all(shine_tree.empty, fn(x) { x == 0 })
/// // -> True
/// ```
///
/// ```gleam
/// all(shine_tree.from_list([-1, -42]), fn(x) { x < 0 })
/// // -> True
/// ```
///
/// ```gleam
/// all(shine_tree.from_list([2, 4, 6, 8, 10, 11]), int.is_even)
/// // -> False
/// ```
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

const all_rec = all

fn all_node(node: Node(u), f: fn(u) -> Bool) {
  case node {
    One(a) -> f(a)
    Two(a, b) -> f(a) && f(b)
    Three(a, b, c) -> f(a) && f(b) && f(c)
    Four(a, b, c, d) -> f(a) && f(b) && f(c) && f(d)
  }
}

/// Returns `True` if the predicate `f` returns `True` for any
/// element in the ShineTree. Returns `False` otherwise.
/// 
/// ## Examples
///
/// ```gleam
/// // No items in the tree will always be false
/// any(shine_tree.empty, int.is_even)
/// // -> False
/// ```
///
/// ```gleam
/// any([10, 32, 42, 43, 44], fn(x) { x == 42 })
/// // -> True
/// ```
/// 
/// ```gleam
/// any([3, 4], fn(x) { x + 1 == 42 })
/// // -> False
/// ```
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

/// Returns `True` if the given value is contained in the given tree.
pub fn contains(tree: ShineTree(u), u) {
  use v <- any(tree)
  v == u
}

/// Counts the number of elements in a given ShineTree satisfying a given predicate.
///
/// This function has to traverse the entire tree to determine the number of elements,
/// so it runs in linear time.
/// 
/// ## Examples
/// 
/// ```gleam
/// count(shine_tree.from_list([2, 3, 4, 5, 6, 7, 8, 9, 10]), int.is_even)
/// // -> 5
/// ```
pub fn count(tree: ShineTree(u), where f: fn(u) -> Bool) {
  use acc, u <- fold_l(tree, 0)
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

/// Calls a function for each element in the tree, discarding the return value.
pub fn each(tree: ShineTree(u), f: fn(u) -> v) -> Nil {
  use _, item <- fold_l(tree, Nil)
  f(item)
  Nil
}

/// Returns a new tree containing only the elements from the first tree
/// where the given function returns `Ok(b)`.
pub fn filter_map(tree: ShineTree(u), f: fn(u) -> Result(b, c)) {
  {
    use acc, item <- fold_l(tree, [])
    case f(item) {
      Ok(b) -> [b, ..acc]
      _ -> acc
    }
  }
  |> do_from_list_reverse
}

/// Fold a given value over the items of a given tree, starting with the beginning until the
/// given function returns `Stop`.
/// 
/// The accumulated value is then returned.
/// 
/// ## Examples
/// 
/// ```gleam
/// fold_until(shine_tree.from_list([2, 3, 4, 5, 6, 7, 8, 9, 10]), 0, fn(acc, x) {
///   case x {
///     5 -> Stop(acc + 1)
///     _ -> Continue(acc + x)
///   }
/// })
/// // -> 10
pub fn fold_l_until(
  tree: ShineTree(u),
  v,
  with f: fn(v, u) -> ContinueOrStop(v),
) -> v {
  do_fold_l_until(tree, v, f) |> unwrap_fold_until
}

/// This is an alias for `fold_l_until`
pub const fold_until = fold_l_until

/// Fold a given value over the items of a given tree, starting with the end until the
/// given function returns `Stop`.
/// 
/// The accumulated value is then returned.
pub fn fold_r_until(
  tree: ShineTree(u),
  v,
  with f: fn(v, u) -> ContinueOrStop(v),
) -> v {
  do_fold_r_until(tree, v, f) |> unwrap_fold_until
}

/// This is an alias for `fold_r_until`
pub const fold_right_until = fold_r_until

fn do_fold_l_until(tree: ShineTree(u), v, f: fn(v, u) -> ContinueOrStop(v)) {
  case tree {
    Empty -> Continue(v)
    Single(u) -> f(v, u)
    Deep(_, pf, root, sf) -> {
      use v <- try_continue(do_fold_node_l_until(pf, v, f))
      use v <- try_continue({
        use v, node <- do_fold_l_until_rec(root, v)
        do_fold_node_l_until(node, v, f)
      })
      do_fold_node_l_until(sf, v, f)
    }
  }
}

fn do_fold_r_until(tree: ShineTree(u), v, f: fn(v, u) -> ContinueOrStop(v)) {
  case tree {
    Empty -> Continue(v)
    Single(u) -> f(v, u)
    Deep(_, pf, root, sf) -> {
      use v <- try_continue(do_fold_node_r_until(sf, v, f))
      use v <- try_continue({
        use v, node <- do_fold_r_until_rec(root, v)
        do_fold_node_r_until(node, v, f)
      })
      do_fold_node_r_until(pf, v, f)
    }
  }
}

const do_fold_r_until_rec = do_fold_r_until

const do_fold_l_until_rec = do_fold_l_until

fn try_continue(v: ContinueOrStop(v), f: fn(v) -> ContinueOrStop(v)) {
  case v {
    Continue(v) -> f(v)
    v -> v
  }
}

fn do_fold_node_l_until(node: Node(u), v, f: fn(v, u) -> ContinueOrStop(v)) {
  case node {
    One(a) -> f(v, a)
    Two(a, b) -> {
      use v <- try_continue(f(v, a))
      f(v, b)
    }

    Three(a, b, c) -> {
      use v <- try_continue(f(v, a))
      use v <- try_continue(f(v, b))
      f(v, c)
    }
    Four(a, b, c, d) -> {
      use v <- try_continue(f(v, a))
      use v <- try_continue(f(v, b))
      use v <- try_continue(f(v, c))
      f(v, d)
    }
  }
}

fn do_fold_node_r_until(node: Node(u), v, f: fn(v, u) -> ContinueOrStop(v)) {
  case node {
    One(a) -> f(v, a)
    Two(b, a) -> {
      use v <- try_continue(f(v, a))
      f(v, b)
    }

    Three(c, b, a) -> {
      use v <- try_continue(f(v, a))
      use v <- try_continue(f(v, b))
      f(v, c)
    }
    Four(d, c, b, a) -> {
      use v <- try_continue(f(v, a))
      use v <- try_continue(f(v, b))
      use v <- try_continue(f(v, c))
      f(v, d)
    }
  }
}

/// Creates a tree of `n` consecutive integers, starting from `start`.
/// and finishing with `finish`.
/// 
/// ## Examples
/// 
/// ```gleam
/// let ten_items = shine_tree.range(1, 10)
/// ```
/// 
pub fn range(start: Int, finish: Int) {
  case finish - start {
    // TODO: make this algorithm backwards instead of calling reverse
    val if val < 0 -> range(finish, start) |> reverse
    0 -> Single(start)
    1 -> Deep(2, One(start), Empty, One(finish))
    2 -> Deep(3, range_2(start), Empty, One(finish))
    3 -> Deep(4, Two(start, start + 1), Empty, Two(start + 2, finish))
    4 ->
      Deep(5, Three(start, start + 1, start + 2), Empty, Two(start + 3, finish))

    5 ->
      Deep(
        6,
        Three(start, start + 1, start + 2),
        Empty,
        Three(start + 3, start + 4, finish),
      )
    6 ->
      Deep(
        7,
        Four(start, start + 1, start + 2, start + 3),
        Empty,
        Three(start + 4, start + 5, finish),
      )
    7 ->
      Deep(
        8,
        Four(start, start + 1, start + 2, start + 3),
        Empty,
        Four(start + 4, start + 5, start + 6, finish),
      )
    8 ->
      Deep(
        9,
        Four(start, start + 1, start + 2, start + 3),
        Single(One(start + 4)),
        Four(start + 5, start + 6, start + 7, finish),
      )
    9 ->
      Deep(
        10,
        Four(start, start + 1, start + 2, start + 3),
        Single(Two(start + 4, start + 5)),
        Four(start + 6, start + 7, start + 8, finish),
      )
    10 ->
      Deep(
        11,
        Four(start, start + 1, start + 2, start + 3),
        Single(Three(start + 4, start + 5, start + 6)),
        Four(start + 7, start + 8, start + 9, finish),
      )

    11 ->
      Deep(
        12,
        Four(start, start + 1, start + 2, start + 3),
        Single(Four(start + 4, start + 5, start + 6, start + 7)),
        Four(start + 8, start + 9, start + 10, finish),
      )

    n ->
      Deep(
        n + 1,
        range_4(start),
        do_deep_range(start + 4, finish - 4, []),
        range_4(finish - 3),
      )
  }
}

fn do_deep_range(
  start: Int,
  finish: Int,
  acc: List(Node(Int)),
) -> ShineTree(Node(Int)) {
  case finish - start {
    0 ->
      [One(start), ..acc]
      |> do_from_list_reverse
    1 ->
      [range_2(start), ..acc]
      |> do_from_list_reverse
    2 ->
      [range_3(start), ..acc]
      |> do_from_list_reverse
    3 ->
      [range_4(start), ..acc]
      |> do_from_list_reverse
    4 ->
      [One(finish), range_4(finish - 4), ..acc]
      |> do_from_list_reverse
    _ -> do_deep_range(start + 4, finish, [range_4(start), ..acc])
  }
}

fn range_4(start: Int) {
  Four(start, start + 1, start + 2, start + 3)
}

fn range_3(start: Int) {
  Three(start, start + 1, start + 2)
}

fn range_2(start: Int) {
  Two(start, start + 1)
}

/// Compares two trees for equality. Since trees can have many shapes, the items
/// can be in the correct order and values, but the tree is balanced differently.
/// 
/// This function reduces over the two trees and compares their values, immediately
/// returning `False` if they are not equal.
/// 
pub fn equals(a: ShineTree(u), b: ShineTree(u)) {
  case a, b {
    a, b if a == b -> True
    a, b ->
      case shift(a), shift(b) {
        Ok(#(item_a, a)), Ok(#(item_b, b)) if item_a == item_b -> equals(a, b)
        _, _ -> False
      }
  }
}

/// Sort a `ShineTree` using the `compare` function using a "quicksort" algorithm.
pub fn sort(tree: ShineTree(u), compare: fn(u, u) -> Order) -> ShineTree(u) {
  case tree {
    Empty -> Empty
    Single(u) -> Single(u)
    _ -> {
      let assert Ok(#(pivot, tree)) = shift(tree)
      let #(left, right) = partition(tree, pivot, compare)
      let left = list.sort(left, compare)
      let right = [pivot, ..list.sort(right, compare)]

      list.append(left, right) |> from_list
    }
  }
}

fn partition(tree: ShineTree(u), pivot: u, compare: fn(u, u) -> Order) {
  use #(left, right), item <- fold_l(tree, #([], []))
  case compare(item, pivot) {
    Gt -> #(left, [item, ..right])
    _ -> #([item, ..left], right)
  }
}

// Get the first item in the tree, if it exists.
pub fn first(tree: ShineTree(u)) -> Result(u, Nil) {
  case tree {
    Deep(_, One(u), _, _) -> Ok(u)
    Deep(_, Two(u, _), _, _) -> Ok(u)
    Deep(_, Three(u, _, _), _, _) -> Ok(u)
    Deep(_, Four(u, _, _, _), _, _) -> Ok(u)
    Single(u) -> Ok(u)
    _ -> Error(Nil)
  }
}

/// This is an alias for `first`.
pub const head = first

// Get the last item in the tree, if it exists.
pub fn last(tree: ShineTree(u)) -> Result(u, Nil) {
  case tree {
    Deep(_, _, _, One(u)) -> Ok(u)
    Deep(_, _, _, Two(_, u)) -> Ok(u)
    Deep(_, _, _, Three(_, _, u)) -> Ok(u)
    Deep(_, _, _, Four(_, _, _, u)) -> Ok(u)
    Single(u) -> Ok(u)
    _ -> Error(Nil)
  }
}

/// This is an alias for `last`.
pub const tail = last

/// This function takes the tree, and groups the values by a returned key into a `Dict`.
/// It does not sort the values, or preserve the order.
pub fn group(tree: ShineTree(u), f: fn(u) -> key) -> Dict(key, ShineTree(u)) {
  case tree {
    Empty -> dict.new()
    Single(u) -> dict.insert(dict.new(), f(u), Single(u))
    Deep(_, pf, root, sf) -> {
      dict.new()
      |> do_group_by_node(pf, f)
      |> do_group_by(root, f)
      |> do_group_by_node(sf, f)
      |> dict.map_values(fn(_, value) { from_list(value) })
    }
  }
}

fn do_group_by_node(
  final_dict: Dict(key, List(u)),
  item: Node(u),
  f: fn(u) -> key,
) {
  case item {
    One(u) -> {
      let u_key = f(u)
      let u_list = [u, ..dict.get(final_dict, u_key) |> result.unwrap([])]
      dict.insert(final_dict, u_key, u_list)
    }
    Two(u, v) -> {
      let u_key = f(u)
      let v_key = f(v)
      let u_list = [u, ..dict.get(final_dict, u_key) |> result.unwrap([])]
      dict.insert(final_dict, u_key, u_list)
      let v_list = [v, ..dict.get(final_dict, v_key) |> result.unwrap([])]
      dict.insert(final_dict, v_key, v_list)
    }
    Three(u, v, w) -> {
      let u_key = f(u)
      let v_key = f(v)
      let w_key = f(w)
      let u_list = [u, ..dict.get(final_dict, u_key) |> result.unwrap([])]
      dict.insert(final_dict, u_key, u_list)
      let v_list = [v, ..dict.get(final_dict, v_key) |> result.unwrap([])]
      dict.insert(final_dict, v_key, v_list)
      let w_list = [w, ..dict.get(final_dict, w_key) |> result.unwrap([])]
      dict.insert(final_dict, w_key, w_list)
    }
    Four(u, v, w, x) -> {
      let u_key = f(u)
      let v_key = f(v)
      let w_key = f(w)
      let x_key = f(x)
      let u_list = [u, ..dict.get(final_dict, u_key) |> result.unwrap([])]
      dict.insert(final_dict, u_key, u_list)
      let v_list = [v, ..dict.get(final_dict, v_key) |> result.unwrap([])]
      dict.insert(final_dict, v_key, v_list)
      let w_list = [w, ..dict.get(final_dict, w_key) |> result.unwrap([])]
      dict.insert(final_dict, w_key, w_list)
      let x_list = [x, ..dict.get(final_dict, x_key) |> result.unwrap([])]
      dict.insert(final_dict, x_key, x_list)
    }
  }
}

fn do_group_by(
  dict: Dict(key, List(u)),
  tree: ShineTree(Node(u)),
  f: fn(u) -> key,
) {
  use final_dict, item <- fold_l(tree, dict)
  do_group_by_node(final_dict, item, f)
}

/// Get the value at the given index in the tree if it exists.
pub fn get(tree: ShineTree(u), index: Int) -> Result(u, Nil) {
  case tree, index {
    Empty, _ -> Error(Nil)
    Single(u), 0 -> Ok(u)
    Single(_), _ -> Error(Nil)
    Deep(count, _, _, _), index if index >= count || index < 0 -> Error(Nil)
    Deep(_, One(u), _, _), 0 -> Ok(u)
    Deep(_, Two(u, _), _, _), 0 -> Ok(u)
    Deep(_, Three(u, _, _), _, _), 0 -> Ok(u)
    Deep(_, Four(u, _, _, _), _, _), 0 -> Ok(u)
    Deep(_, Two(_, v), _, _), 1 -> Ok(v)
    Deep(_, Three(_, v, _), _, _), 1 -> Ok(v)
    Deep(_, Four(_, v, _, _), _, _), 1 -> Ok(v)
    Deep(_, Three(_, _, w), _, _), 2 -> Ok(w)
    Deep(_, Four(_, _, w, _), _, _), 2 -> Ok(w)
    Deep(_, Four(_, _, _, x), _, _), 3 -> Ok(x)
    Deep(count, _, _, One(u)), index if index == count - 1 -> Ok(u)
    Deep(count, _, _, Two(_, u)), index if index == count - 1 -> Ok(u)
    Deep(count, _, _, Three(_, _, u)), index if index == count - 1 -> Ok(u)
    Deep(count, _, _, Four(_, _, _, u)), index if index == count - 1 -> Ok(u)
    Deep(count, _, _, Two(v, _)), index if index == count - 2 -> Ok(v)
    Deep(count, _, _, Three(_, v, _)), index if index == count - 2 -> Ok(v)
    Deep(count, _, _, Four(_, _, v, _)), index if index == count - 2 -> Ok(v)
    Deep(count, _, _, Three(w, _, _)), index if index == count - 3 -> Ok(w)
    Deep(count, _, _, Four(_, w, _, _)), index if index == count - 3 -> Ok(w)
    Deep(count, _, _, Four(x, _, _, _)), index if index == count - 4 -> Ok(x)
    Deep(_, pf, root, _), index -> {
      let index = index - node_size(pf)
      do_get_root(root, index)
    }
  }
}

fn do_get_root(node: ShineTree(Node(u)), index: Int) {
  {
    use index, node <- fold_until(node, Error(index))
    let assert Error(index) = index
    get_node(index, node)
  }
  |> result.nil_error
}

fn get_node(index: Int, node: Node(u)) {
  case node, index {
    One(u), 0 -> Stop(Ok(u))
    Two(u, _), 0 -> Stop(Ok(u))
    Two(_, v), 1 -> Stop(Ok(v))
    Three(u, _, _), 0 -> Stop(Ok(u))
    Three(_, v, _), 1 -> Stop(Ok(v))
    Three(_, _, w), 2 -> Stop(Ok(w))
    Four(u, _, _, _), 0 -> Stop(Ok(u))
    Four(_, v, _, _), 1 -> Stop(Ok(v))
    Four(_, _, w, _), 2 -> Stop(Ok(w))
    Four(_, _, _, x), 3 -> Stop(Ok(x))
    node, _ -> Continue(Error(index - node_size(node)))
  }
}

fn node_size(node: Node(u)) -> Int {
  case node {
    One(_) -> 1
    Two(_, _) -> 2
    Three(_, _, _) -> 3
    Four(_, _, _, _) -> 4
  }
}

/// Perform a folding operation and return the success `Ok` value,
/// or the error `Error` value if the operation fails.
pub fn try_foldl(
  tree: ShineTree(u),
  acc,
  f: fn(acc, u) -> Result(acc, err),
) -> Result(acc, err) {
  use acc, u <- fold_l_until(tree, Ok(acc))
  let assert Ok(acc) = acc
  case f(acc, u) {
    Ok(u) -> Continue(Ok(u))
    Error(err) -> Stop(Error(err))
  }
}

/// This is an alias for `try_foldl`
pub const try_fold = try_foldl

/// Perform a folding operation and return the success `Ok` value,
/// or the error `Error` value if the operation fails immediately.
pub fn try_foldr(
  tree: ShineTree(u),
  acc,
  f: fn(acc, u) -> Result(acc, err),
) -> Result(acc, err) {
  use acc, u <- fold_r_until(tree, Ok(acc))
  let assert Ok(acc) = acc
  case f(acc, u) {
    Ok(acc) -> Continue(Ok(acc))
    Error(err) -> Stop(Error(err))
  }
}

/// Maps all the elements of the given tree into a new tree where
/// each element has been transformed by the given function if the
/// function returns `Ok(val)`. If the function returns `Error(err)`,
/// the error returns immediately.
pub fn try_map(
  tree: ShineTree(u),
  f: fn(u) -> Result(v, err),
) -> Result(ShineTree(v), err) {
  case tree {
    Empty -> Ok(Empty)
    Single(u) -> {
      use u <- result.map(f(u))
      Single(u)
    }
    Deep(count, pf, root, sf) -> {
      use pf <- try(try_map_node(pf, f))
      use root <- try(try_map_root(root, f))
      use sf <- result.map(try_map_node(sf, f))
      Deep(count, pf, root, sf)
    }
  }
}

fn try_map_root(root: ShineTree(Node(u)), f: fn(u) -> Result(v, err)) {
  use node <- try_map(root)
  try_map_node(node, f)
}

fn try_map_node(node: Node(u), f: fn(u) -> Result(v, err)) {
  case node {
    One(w) -> {
      use w <- result.map(f(w))
      One(w)
    }
    Two(w, x) -> {
      use w <- try(f(w))
      use x <- result.map(f(x))
      Two(w, x)
    }
    Three(w, x, y) -> {
      use w <- try(f(w))
      use x <- try(f(x))
      use y <- result.map(f(y))
      Three(w, x, y)
    }
    Four(w, x, y, z) -> {
      use w <- try(f(w))
      use x <- try(f(x))
      use y <- try(f(y))
      use z <- result.map(f(z))
      Four(w, x, y, z)
    }
  }
}
//   pub fn map(tree: ShineTree(u), with f: fn(u) -> v) -> ShineTree(v) {
//   case tree {
//     Empty -> Empty
//     Single(u) -> Single(f(u))
//     Deep(count, pf, root, sf) -> {
//       let pf = map_node(pf, f)
//       let root = map_root(root, f)
//       let sf = map_node(sf, f)
//       Deep(count, pf, root, sf)
//     }
//   }
// }

// fn map_node(node: Node(u), f: fn(u) -> v) -> Node(v) {
//   case node {
//     One(w) -> One(f(w))
//     Two(w, x) -> Two(f(w), f(x))
//     Three(w, x, y) -> Three(f(w), f(x), f(y))
//     Four(w, x, y, z) -> Four(f(w), f(x), f(y), f(z))
//   }
// }

// fn map_root(root: ShineTree(Node(u)), f: fn(u) -> v) -> ShineTree(Node(v)) {
//   use node <- map(root)
//   map_node(node, f)
// }
