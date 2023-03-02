struct Stack<Element> {
  var items: [Element] = []
  mutating func push(_ item: Element) {
    items.append(item)
  }

  mutating func pop() -> Element? {
    if items.count > 0 {
      return items.removeLast()
    } else {
      return nil
    }
  }
}

extension Stack {
  var topItem: Element? {
    return items.isEmpty ? nil : items[items.count - 1]
  }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

if let topItem = stackOfStrings.topItem {
  print("TopItem is \(topItem)")
}

if let cuatro = stackOfStrings.pop(), let tres =  stackOfStrings.pop(), let dos = stackOfStrings.pop(), let uno = stackOfStrings.pop() {
  print(cuatro)
  print(tres)
  print(dos)
  print(uno)
}
