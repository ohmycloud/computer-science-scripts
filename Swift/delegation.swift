// Delegation is a design pattern that enables a class or structure to hand off(or delegate) some of its responsibilities to an instance of another type
// This design pattern is implemented by defined a protocol that encapsulates the delegated responsibilities, such that a conforming type(know as a  delegate)
//  is guaranteed to provide the functionality that has been delegated
// delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to konw the underlying type of that source

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


protocol DiceGame {
  var dice: Dice { get }
  func play()
}

protocol DiceGameDelegate: AnyObject {
  func gameDidStart(_ name: DiceGame)
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
  func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
  let finalSquare = 25
  let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
  var square = 0
  var board: [Int]
  init() {
    board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
  }
  weak var delegate: DiceGameDelegate?
  func play() {
    square = 0
    delegate?.gameDidStart(self)

    gameLoop: while square != finalSquare {
    let diceRoll = dice.roll()
    delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
    switch square + diceRoll {
    case finalSquare:
      break gameLoop
    case let newSquare where newSquare > finalSquare:
      continue gameLoop
    default:
      square += diceRoll
      square += board[square]
    }
  }
  delegate?.gameDidEnd(self)
}
}

class DiceGameTracker: DiceGameDelegate {
  var numberOfTurns = 0
  func gameDidStart(_ game: DiceGame) {
    numberOfTurns = 0
    if game is SnakesAndLadders {
      print("Started a new game of Snakes and Ladders")
    }
    print("The game is using a \(game.dice.sides) - sided dice")
  }

  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
    numberOfTurns += 1
    print("Rolled a \(diceRoll)")
  }

  func gameDidEnd(_ game: DiceGame) {
    print("The game lasted for \(numberOfTurns) turns")
  }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


















