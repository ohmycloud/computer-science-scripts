// enum with raw values antomatically receive a failable initializer, ini?(rawValue:)
enum TemperatureUnit: Character {
  case kevin = "K", celsisu = "C", fahrenheit = "F"
}

if let kk = TemperatureUnit(rawValue: "G") {
   print(kk)
} else {
   print("nil")
}
