import Foundation

func initToWord(_ number: Int) -> String? {
  let formatter = NumberFormatter()
  formatter.numberStyle = .spellOut
  return formatter.string(from: number as NSNumber)
}

func shouldKeep(word: String) -> Bool {
  return word.count == 4
}

let numbers: [Int] = Array(0...100)
let words = numbers.compactMap(initToWord(_:)).filter { $0.count == 4 }
for i in words { print(i)}
