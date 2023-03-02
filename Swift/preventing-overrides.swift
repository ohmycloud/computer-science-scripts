class BlackHole {
  var radius: Int = 1000
  var description: String {
    return "\(radius) is so big"
  }
  final func demo(s: String) -> String {
    return "\(s) is too love"
  }
}

class SmallBlackHole: BlackHole {
  override func demo(s: String) -> String {
    super.demo(s: "Rakudo") 
  }
}

let smallBlackHole = SmallBlackHole()
print(smallBlackHole.demo(s: "moarvm"))
