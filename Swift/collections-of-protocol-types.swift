protocol TextRepresentable {
  var textualDescription: String { get }
}

extension Int: TextRepresentable {
  var textualDescription: String {
    return "This is \(self)"
  }
}

struct Person {
  var name: String
  var age: Int
}

extension Person: TextRepresentable {
  var textualDescription: String {
    return "\(self.name) is \(self.age) years old"
  }
}

let lotOfTextRepresentable: [TextRepresentable] = [Person(name: "Tom", age: 17), 18]
for textRepresentable in lotOfTextRepresentable {
  print("\(textRepresentable.textualDescription)")
}
