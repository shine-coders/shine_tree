# Examples

A simple FIFO work queue:

```gleam
pub type Queue(item) {
  Queue(items: FingerTree(item))
}

pub fn new() {
  shine_tree.empty
}

pub fn enqueue(queue: Queue(item), item) {
  Queue(shine_tree.push(queue.items, item))
}

pub fn dequeue(queue: Queue(item)) {
  case shine_tree.shift(queue.items) {
    Error(_) -> None
    Ok(#(item, rest)) -> Some(#(item, Queue(rest)))
  }
}
