// Protocols don’t actually implement any functionality themselves. 
// Nonetheless, you can use protocols as a fully fledged types in your code. 
// Using a protocol as a type is sometimes called an existential type, 
// which comes from the phrase “there exists a type T such that T conforms to the protocol”

// use a protocol in many places where other types are allowed
// 1. as a parameter type or return type in a function, method, or initializer
// 2. as the type of a constant, variable, or property
// 3. As the type of items in an array, dictionary, or other container

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}


protocol RandomNumberGenerator {
   func random() -> Double
}

// A example of a protocol used as a type
class Dice {
  let sides: Int
  let generator: RandomNumberGenerator
  init(sides: Int, generator: RandomNumberGenerator) {
    self.sides = sides
    self.generator = generator
  }

  func roll() -> Int {
    return Int(generator.random() * Double(sides)) + 1
  }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
  print("Random dice roll is \(d6.roll())")
}

protocol DiceGame {
  var dice: Dice { get }
  func play()
}

protocol DiceGameDelegate: AnyObject {
  func gameDidStart(_ name: DiceGame)
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
  func gameDidEnd(_ game: DiceGame)
}











