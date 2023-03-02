// Type constraints specity that a type parameter must inhert from a specific class, or conform to a particular protocol
//  or protocol composition

func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
  for (index, value) in array.enumerated() {
    if value == valueToFind { return index }
  }
  return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundindex = findIndex(of: "llama", in: strings) {
  print(foundindex)
}

if let idx = findIndex(of: 9.3, in: [3.1315926, 0.1, 0.25]) {
  print("idx = \(idx)")
} else {
  print("no idx")
}
