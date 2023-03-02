// When you define a protocol extension, you can specify constraints that conforming type must satisfy before the methods and properties of the extension are avaiable

extension Collection where Element: Equatable {
  func allEqual() -> Bool {
    for element in self {
      if element != self.first { return false }
    }
    return true
  }
}

let a = [1,1,1,1]
print(a.allEqual())
