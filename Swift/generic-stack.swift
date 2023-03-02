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

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

if let cuatro = stackOfStrings.pop(), let tres =  stackOfStrings.pop(), let dos = stackOfStrings.pop(), let uno = stackOfStrings.pop() {
  print(cuatro)
  print(tres)
  print(dos)
  print(uno)
}
