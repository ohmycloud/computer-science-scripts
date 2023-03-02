import Foundation

struct Point {
  var x: Float = 0.0
  var y: Float = 0.0

  func area() -> Float {
    return sqrt(x * x + y * y)
  }
}

var p = Point(x: 4.0, y: 3.0)
let anotherPoint = p
p.x = 6.0
p.y = 8.0
print(p.area())

// structure 是值类型
print(anotherPoint.area())

// 枚举是值类型
enum CompassPoint {
  case north, south, east, west
  mutating func turnNorth() {
    self = .north
  }
}

var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()
print("currentDirection is \(currentDirection)")
print("rememberedDirection is \(rememberedDirection)")

// 类是引用类型
class ClassPoint {
  var x = 0.0
  var y = 0.0

  init(x: Double, y: Double) {
     self.x = x
     self.y = y
  }

  func area() -> Double {
    return sqrt(x * x + y * y)
  }
}

let classOfPoint = ClassPoint(x: 3, y: 4)
let anotherClassOfPoint = classOfPoint
anotherClassOfPoint.x = 6
anotherClassOfPoint.y = 8

// Identical to means that two constants or 
//    variables of class type refer to exactly the same class instance
if classOfPoint === anotherClassOfPoint {
  print("two instance is the same")
}

print(classOfPoint.area())
