// When defining a protocol, it's sometimes useful to dec;are one or more associated types as part of the protocol's definition
// An associated type gives a placeholder name to a type that's used as part of the protocol
// The actual type to use for that associated type isn't specified until the protocol is adopted
// Associated types are specified with the associatedtype keyword
protocol Container {
  associatedtype Item
  mutating func append(_ item: Item)
  var count: Int { get }
  subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
  // original IntStack implementation
  var items: [Int] = []
  mutating func push(_ item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }

  // conformance to the Container protocol
  typealias Item = Int
  mutating func append(_ item: Int) {
    self.push(item)
  }
  var count: Int { return items.count }
  subscript(i: Int) -> Int {
    return items[i]
  }
}

var intStack = IntStack()
intStack.push(1)
intStack.push(3)
intStack.append(5)
print(intStack.count)
print(intStack[2])

struct Stack<Element>: Container {
  // original Stack<Element> implementation
  var items: [Element] = []
  mutating func push(_ item: Element) {
    items.append(item)
  }
  mutating func pop() -> Element {  return items.removeLast() }

  // conformance to the Container protocol
  mutating func append(_ item: Element) {
    self.push(item)
  }
  var count: Int {  return items.count }
  subscript(i: Int) -> Element {
     return items[i]
  }
}

















