protocol TextRepresentable {
  var textualDescription: String { get }
}

struct Hamster {
  var name: String
  var textualDescription: String {
    return "A hamster named \(name)"
  }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
