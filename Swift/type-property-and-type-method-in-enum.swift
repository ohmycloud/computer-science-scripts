struct LevelTracker {
  // keeps track of the highest level that any player has unlocked
  static var highestUnlockedLevel = 1
  var currentLevel = 1

  // a new level is unlocked
  static func unlock(_ level: Int) {
    if level > highestUnlockedLevel { highestUnlockedLevel = level }
  }

  static func isUnlocked(_ level: Int) -> Bool {
    return level <= highestUnlockedLevel
  }

  @discardableResult
  mutating func advance(to level: Int) -> Bool {
    if LevelTracker.isUnlocked(level) {
      currentLevel = level
      return true
    } else {
      return false
    }
  }
}

class Player {
  var tracker = LevelTracker()
  let playerName: String
  
  func complete(level: Int) {
    LevelTracker.unlock(level + 1)
    tracker.advance(to: level + 1)
  }
  init(name: String) {
    playerName = name
  }
}

var player = Player(name: "Abcde")
player.complete(level: 1)
print("已解锁的最高级是 \(LevelTracker.highestUnlockedLevel)")


player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
  print("游戏玩家在第六级")
} else {
  print("第六级还未解锁")
}
