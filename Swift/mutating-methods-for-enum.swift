enum TriStateSwitch {
  case off, low, high
  mutating func next() {
    switch self {
    case .off:
      self = .low
    case .low:
      self = .high
    case .high:
      self = .off
    }
  }
}

var overLight = TriStateSwitch.low
overLight.next()
print(overLight)
overLight.next()
print(overLight)
