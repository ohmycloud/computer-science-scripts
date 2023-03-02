class Vehicle {
  var currentSpeed = 0.0
  var description: String {
    return "traveling at \(currentSpeed) miles per hour"
  }
  func makeNoise() {}
}

let someVehicle = Vehicle()
print(someVehicle.description)

class Bicycle: Vehicle {
  var hasBasket = false

  override func makeNoise() {
    print("Hello kugou")
  }
}

let someBicycle = Bicycle()
someBicycle.currentSpeed = 120.0
print(someBicycle.description)
print(someBicycle.makeNoise())
