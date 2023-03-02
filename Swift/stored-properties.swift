struct FixedLengthRange {
  var firstValue: Int
  let length: Int
}

var rangerOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangerOfThreeItems.firstValue = 6
print(rangerOfThreeItems)

// stored properties of COnstant Structure Instance
let rangerOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
rangerOfFourItems.firstValue = 6
