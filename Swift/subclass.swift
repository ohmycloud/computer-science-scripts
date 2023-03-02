class NamedShape {
  var numberOfSides: Int = 0
  var name: String

  init(name: String) {
    self.name = name
  }
  deinit {
    print("Goodbye, \(self.name)")
  }

  func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}    

class Square: NamedShape {
        var sideLength: Double

        init(sideLength: Double, name: String) {
            self.sideLength = sideLength
            super.init(name: name)
            numberOfSides = 4
        }

        func area() -> Double {
            return sideLength * sideLength
        }

        override func simpleDescription() -> String {
            return "A square with sides of length \(sideLength), numberOfSides = \(numberOfSides)."
        }
    }
    let test = Square(sideLength: 5.2, name: "my test square")
    print(test.area())
    print(test.simpleDescription())
