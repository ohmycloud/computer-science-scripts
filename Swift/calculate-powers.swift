func calculatePowers(_ number: Int) -> [Int] {
  var results: [Int] = []
  var value = number
  for _ in 0...2 {
    value *= number
    results.append(value)
  }
  return results
}

let exampleList = [1,2,3,4,5]
let result = exampleList.flatMap(calculatePowers(_:))
print(result.count)
