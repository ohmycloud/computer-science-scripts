enum TemperatureUnit {
  case kevin, celsius, fahreheit
  init?(symbol: Character) {
    switch symbol {
      case "K":
        self = .kevin
      case "C":
        self = .celsius
      case "F":
        self = .fahreheit
      default:
        return nil
    }
  }
}

let fas = TemperatureUnit(symbol: "X")
if let fa = fas {
  print(fa)
} else {
  print("nil")
}
