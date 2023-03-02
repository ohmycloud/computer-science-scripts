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

var np = NamedShape(name: "Tom")

print(np.name, np.simpleDescription())
np = NamedShape(name: "Bob")
print("Good")
