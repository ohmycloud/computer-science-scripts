import Foundation

let words: [String] = Array(0...10).compactMap {number in
  let formatter = NumberFormatter()
  formatter.numberStyle = .spellOut
  return formatter.string(from: number as NSNumber)
}

print(words.sorted(by: >))
