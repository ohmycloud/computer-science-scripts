struct AudioChannel {
  static let thresholdLevel = 10
  static var maxInputLevelForAllChannels = 0
  var currentLevel: Int = 0 {
    didSet {
      if currentLevel > AudioChannel.thresholdLevel {
        currentLevel = AudioChannel.thresholdLevel
      }
      if currentLevel > AudioChannel.maxInputLevelForAllChannels {
        AudioChannel.maxInputLevelForAllChannels = currentLevel
      }
    }
  }
}

    var leftChannel = AudioChannel()
    var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Prints "7"
print(AudioChannel.maxInputLevelForAllChannels)


    rightChannel.currentLevel = 11
    print(rightChannel.currentLevel)
    // Prints "10"
    print(AudioChannel.maxInputLevelForAllChannels)
    // Prints "10"
