// A property wrapper adds a layer of separation between code 
//   that manages how a property is stored and the code that defines a property

// When you use a property wrapper, you write the management code 
//   once when you define the wrapper, and then reuse that management code by 
//     applying it to multiple properties.

// 语法类似于 Python 的装饰器?
@propertyWrapper
struct TwelveOrLess {
  private var number = 0
  var wrappedValue: Int {
    get {
      number
    }
    set {
      number = min(newValue, 12)
    } 
  }
}

var tol = TwelveOrLess()
tol.wrappedValue = 13
print(tol.wrappedValue)

struct SmallRectangle {
  @TwelveOrLess var height: Int
  @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"
