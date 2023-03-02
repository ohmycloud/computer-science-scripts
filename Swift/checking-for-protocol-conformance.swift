// You can use the is and as operators described in Type Casting to check for protocol conformance
//  and to cast to a specific protocol
// Checking for and casting to a protocol follows the same syntax as checking for and casting to a type

// The is operator returns true if an instance conforms to a protocol and returns false if it doesn't
// The as? version of downcast opeartor returns an optional value of the protocol's type
// and this value is nil if the instance doesn't conform to that protocol
// The as! version of the downcast operator forces the downcast to the protocol type and trigger a runtime error if the downcast doesn't succeed

protocol HasArea {
  var area: Double { get }
}

class Circle: HasArea {
  let pi = 3.1415927
  var radius: Double
  var area: Double {
    return pi * radius * radius
  }
  init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
  var area: Double
  init(area: Double) { self.area = area }
}

class Animal {
  var legs: Int
  init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
  Circle(radius: 2.0),
  Country(area: 243_610),
  Animal(legs: 4)
]

for object in objects {
  if let objectWithArea = object as? HasArea {
    print("Area is \(objectWithArea.area)")
  } else {
    print("Something doesn't have an area")
  }
}












