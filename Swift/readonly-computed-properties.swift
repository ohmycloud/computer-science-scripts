// A computed property with a getter but no setter is known as a read-only computed property
// You can simplify the declaration of a read-only computed property by removing the get keyword and its braces

struct Cuboid {
  var width = 0.0, height = 0.0, depth = 0.0
  // 'let' declarations cannot be computed properties
  var volume: Double {
    return width * height * depth
  }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("volume is \(fourByFiveByTwo.volume)")
