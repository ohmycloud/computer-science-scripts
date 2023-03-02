func minMax(array: [Int]) -> (min: Int, max: Int)? {
  guard var currentMin = array.first, var currentMax = array.first else {
      return nil
  }

  for value in array[1..<array.count] {
    if value < currentMin {
      currentMin = value
    } else if value > currentMax {
      currentMax = value
    }
  }
  return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
  print("min is \(bounds.min) and max is \(bounds.max)")
}
