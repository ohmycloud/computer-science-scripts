class Counter {
  var count = 0
  func increment() {
    count += 1
  }
  func increment(by amount: Int) {
    count += amount
  }
  func reset() {
    count = 0
  }
}

let c = Counter()
print(c.count)
c.increment()
print(c.count)
c.increment(by: 10)
print(c.count)
c.reset()
print(c.count)
