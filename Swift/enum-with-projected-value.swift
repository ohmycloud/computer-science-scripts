@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
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

enum Size {
  case small, large
}

struct SizedRectangle {
  @SmallNumber var height: Int
  @SmallNumber var width: Int

  mutating func resize(to size: Size) -> Bool {
    switch size {
      case .small:
        height = 10
        width = 20
      case .large:
        height = 100
        width = 100
    }
  return $height || $width
  }
}
