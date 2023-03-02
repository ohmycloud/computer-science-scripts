import Foundation

extension Int {
  func word() -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: self as NSNumber)
  }
}

print(1.word()!)
print(36.word()!)
print(Int.word(36)()!)
