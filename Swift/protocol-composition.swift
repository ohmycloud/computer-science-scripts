// It can be useful to require a type to conform to multiple protocols at the same time
// You can combine multiple protocols into a single requiremnet with a protocol composition
// Protocol compositions behave as if you defined a temporary local protocol that has the combined requirements of all protocols in the composition
// Protocol compositions don't define any new protocol types

// Protocol compositions have the form Someprotocol & AnotherProtocol
protocol Named {
  var name: String { get }
}

protocol Aged {
  var age: Int { get }
}

struct Person: Named, Aged {
  var name: String
  var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
  print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Tom", age: 21)
wishHappyBirthday(to: birthdayPerson)

class Location {
  var latitude: Double
  var longitude: Double

  init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}

class City: Location, Named {
  var name: String
  init(name: String, latitude: Double, longitude: Double) {
    self.name = name
    super.init(latitude: latitude, longitude: longitude)
  }
}

func beginConcert(in location: Location & Named) {
  print("Hello, \(location.name)")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)





















