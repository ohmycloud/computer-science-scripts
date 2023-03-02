// 结构体, 类和枚举都拥有计算属性
// In addition to stored properties, classes, structures, and enumerations can 
//   define computed properties, which don’t actually store a value. 
// Instead, they provide a getter and an optional setter to retrieve 
//   and set other properties and values indirectly.

struct Point {
  var x = 0.0, y = 0.0
}

struct Size {
  var width = 0.0, height = 0.0
}

struct Rect {
  var origin = Point()
  var size = Size()
  var center: Point {
    get {
      let centerX = origin.x + (size.width / 2)
      let centerY = origin.y + (size.height / 2)
      return Point(x: centerX, y: centerY)
    }

    set(newValue) {
      origin.x = newValue.x - (size.width / 2)
      origin.y = newValue.y - (size.height / 2)
    }
  }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0),
                 size: Size(width: 10, height: 10)
                )

print(square)

let initialSquareCenter = square.center
print("initialSquareCenter is \(initialSquareCenter)")

square.center = Point(x: 15, y: 15)
print("square.origin is now at \(square.origin)")
