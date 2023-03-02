struct IntStack {
  var items: [Int] = []
  mutating func push(_ item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }
}
