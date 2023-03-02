class Shape {
  var numberOfSides = 0
  let numberOfLegs = 4
  func simpleDescription() -> String {
    return "A shape with \(numberOfSides)"
  }

  func greet(number of: Int) -> String {
    return "Has \(of) legs"
  }
}

var shape = Shape()
shape.numberOfSides = 10
print(shape.simpleDescription())
//shape.numberOfLegs = 20
print(shape.greet(number: 100))
