func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

let makeIncrementerOfFive = makeIncrementer(forIncrement: 5)
let res0 = makeIncrementerOfFive()
print(res0)

let res1 = makeIncrementerOfFive()
print(res1)
let res2 = makeIncrementerOfFive()
print(res2)
