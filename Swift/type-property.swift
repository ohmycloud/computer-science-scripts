struct SomeStructure {
  static var storedTypeProperty = "Some value"
  static var computedTypeProperty: Int {
    1
  }
}

enum SomeEnumeration {
  static var storedTypeProperty = "Some value"
  static var computedTypeProperty: Int {
    5
  }
}

class SomeClass {
  static var storedTypeProperty = "Some value"
  static var computedTypeProperty: Int {
    27
  }
  class var overrideableComputedTypeProperty: Int {
    107
  }
}

    print(SomeStructure.storedTypeProperty)
    // Prints "Some value."
    SomeStructure.storedTypeProperty = "Another value."
    print(SomeStructure.storedTypeProperty)
    // Prints "Another value."
    print(SomeEnumeration.computedTypeProperty)
    // Prints "6"
    print(SomeClass.computedTypeProperty)
    // Prints "27"
