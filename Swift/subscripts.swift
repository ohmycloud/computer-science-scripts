struct TimesTable {
  let multiplier: Int
  subscript(index: Int) -> Int {

    get {
      return multiplier * index
    }
  }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
