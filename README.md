# shine_tree

[![Package Version](https://img.shields.io/hexpm/v/shine_tree)](https://hex.pm/packages/shine_tree)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/shine_tree/)

A `FingerTree` implementation for general purpose functional programming in Gleam!

```rs
pub opaque type ShineTree(u) {
  Empty
  Single(u)
  Deep(count, Node(u), ShineTree(Node(u)), Node(u))
}

type Node(u) {
  One(u)
  Two(u, u)
  Three(u, u, u)
  Four(u, u, u, u)
}
```

## Usage

To install shine_tree into your project, use the following command.


```sh
gleam add shine_tree
```

```gleam
import shine_tree.{empty, push, to_list}

pub fn main() {
  empty
  |> push(1)
  |> push(2)
  |> push(3)
  |> to_list
  |> io.debug
  // [1, 2, 3]
}
```

Most of the list functions in the std library have been implemented along with many more convenience methods like:

- push
- pop
- shift
- unshift
- from_list
- to_list
- from_iterator
- TODO: to_iterator
- TODO: to_set
- TODO: sort

Further documentation can be found at <https://hexdocs.pm/shine_tree>.

## License

```
Copyright © 2024 Joshua Tenner <tenner.joshua@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
