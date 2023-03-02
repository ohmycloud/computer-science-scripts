protocol Togglable {
  mutating func toggle()
}

enum OnOffSwitch: Togglable {
  case off, on
  mutating func toggle() {
    switch self {
      case .off:
        self = .on
      case .on:
        self = .off
    }
  }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
print(lightSwitch)
