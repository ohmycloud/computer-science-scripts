// A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherts
protocol TextRepresentable {
  var textualDescription: String { get }
}

protocol PrettyTextRepresentable {
  var prettyTextualDescription: String { get }
}

struct Person {
  var name: String
  var age: Int
}

extension Person: PrettyTextRepresentable {
  var textualDescription: String {
    return "\(self.name) is \(self.age) years old"
  }

  var prettyTextualDescription: String {
    return """
    Person(name = \(self.name), age = \(self.age))
    """
  }
}

let tom = Person(name: "Tom", age: 18)
print(tom.textualDescription)
print(tom.prettyTextualDescription)
