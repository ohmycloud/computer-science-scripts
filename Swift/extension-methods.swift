extension Int {
  func repetitions(task: () -> Void) {
    for _ in 0..<self {
      task()
    }
  }
}

let f = { print("World") }
3.repetitions(task: f)
3.repetitions {
  print("Hello")
}

extension Int {
  mutating func square() {
    self = self * self
  }
}

var someInt = 3
someInt.square()
print(someInt)

extension Int {
  subscript(digitIndex: Int) -> Int {
    var decimalBase = 1
    for _ in 0..<digitIndex {
       decimalBase *= 10
    }
    return (self / decimalBase) % 10
  }
}

print(746381295[0])
print(746381295[4])
print(746381295[9])



















