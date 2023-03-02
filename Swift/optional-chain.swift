class Person {
  var residence: Residence?
}

class Residence {
  var rooms: [Room] =  []
  var numberOfRooms: Int {
    return rooms.count
  }
  subscript(i: Int) -> Room {
    get {
      return rooms[i]
    }
    set {
      rooms[i] = newValue
    }
  }
  
  func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
  }
  var address: Address?
}

class Room {
  let name: String
   init(name: String) { self.name = name }
}

class Address {
  var buildingName: String?
  var buildingNumber: String?
  var street: String?

  func buildingIdentifier() -> String? {
    if let buildingNumber = buildingNumber, let street = street {
      return "\(buildingNumber) \(street)"
    } else if buildingName != nil {
      return buildingName
    } else {
      return nil
    }
  }
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
let john = Person()
//john.residence = Residence()
//john.residence?.address = someAddress

    func createAddress() -> Address {
        print("Function was called.")

        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"

        return someAddress
    }
    john.residence?.address = createAddress()


if let roomCount = john.residence?.numberOfRooms {
  if let address = john.residence?.address?.buildingIdentifier() {
    print(address)
  }
}
