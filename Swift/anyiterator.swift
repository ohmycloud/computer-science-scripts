let anotherCountdown5 = AnySequence<Int> {() -> 
  AnyIterator<Int> in
  var count = 5
  return AnyIterator<Int> {
    defer { count -= 1}
    return count >= 0 ? count : nil
  }
}

for value in anotherCountdown5 {
    print(value)
}
