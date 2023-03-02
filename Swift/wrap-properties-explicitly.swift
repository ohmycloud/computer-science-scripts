struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
  private var _height = TwelveOrLess()
  private var _width = TwelveOrLess()

  var height: Int {
    get { _height.wrappedValue }
    set { _height.wrappedValue = newValue }
  }
  var width: Int {
    get { _width.wrappedValue }
    set { _width.wrappedValue = newValue }
  }
}

var rec = SmallRectangle()
print(rec)

rec.height = 24
print(rec)
