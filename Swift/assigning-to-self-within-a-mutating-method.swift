struct Point {
  var x = 0.0, y = 0.0
  mutating func moveBy(x deltaX: Double, y deltaY: Double) {
    self = Point(x: x + deltaX, y: y + deltaY)
  }
}

var somePoint = Point(x: 3.0, y: 4.0)
somePoint.moveBy(x: 3.0, y: 4.0)
print(somePoint)
