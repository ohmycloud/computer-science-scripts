struct Size {
  var width = 0.0, height = 0.0
}

struct Point {
  var x = 0.0, y = 0.0
}

struct Rect {
  var origin = Point()
  var size = Size()
  init() {}
  init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }

  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2 )
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}

let basicRect = Rect()
print(basicRect)
