    @propertyWrapper
    struct SmallNumber {
        private var maximum: Int
        private var number: Int

        var wrappedValue: Int {
            get { return number }
            set { number = min(newValue, maximum) }
        }

        init() {
            maximum = 12
            number = 0
        }
        init(wrappedValue: Int) {
            maximum = 12
            number = min(wrappedValue, maximum)
        }
        init(wrappedValue: Int, maximum: Int) {
            self.maximum = maximum
            number = min(wrappedValue, maximum)
        }
    }


struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)

struct UnitRectangle {
  @SmallNumber var height: Int = 1
  @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle)


struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
