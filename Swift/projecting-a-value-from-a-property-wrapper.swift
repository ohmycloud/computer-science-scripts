// The name of the projected value is the same as the wrapped value, 
//   except it begins with a dollar sign ($)
@propertyWrapper
struct SmallNumber {
  private var number: Int
  private(set) var projectedValue: Bool

  var wrappedValue: Int {
    get { number }
    set { 
      if newValue > 12 {
        number = 12
        projectedValue = true
      } else {
        number = newValue
        projectedValue = false
      }
    }
  }
  init() {
      self.number = 0
      self.projectedValue = false
    }
}

struct SomeStructure {
  @SmallNumber var someNumber: Int
  
}

var someStructure = SomeStructure()
someStructure.someNumber = 4
print(someStructure.$someNumber)

someStructure.someNumber = 55
print(someStructure.$someNumber)
