extension Stack where Element: Equatable {
  func isTop(_ item: Element) -> Bool {
    guard let topItem = items.last else {
      return false
    }
    return topItem == item
  }
}
