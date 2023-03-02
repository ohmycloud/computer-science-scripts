protocol Container {
        associatedtype Item
        mutating func append(_ item: Item)
        var count: Int { get }
        subscript(i: Int) -> Item { get }
}

protocol SuffixableContainer: Container {
  associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
  func suffix(_ size: Int) -> Suffix
}

struct Stack<Element> {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

extension Stack: SuffixableContainer {
  func suffix(_ size: Int) -> Stack {
    var result = Stack()
    for index in (count-size)..<count {
      result.append(self[index])
    }
    return result
  }
}

var stackOfInts = Stack<Int>()
stackOfInts.append(10)




























