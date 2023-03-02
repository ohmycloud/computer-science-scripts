struct Point {
  var x = 0.0, y = 0.0
  func isToTheRightOf(x: Double) -> Bool {
    self.x > x
  }
}

let somePoint = Point(x: 3.0, y: 3.0)
if somePoint.isToTheRightOf(x: 1.0) {
  print("ops")
}
