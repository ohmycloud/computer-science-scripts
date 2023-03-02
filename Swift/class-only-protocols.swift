// You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol's inheritance list
protocol Rakudo {
  var star: String { get }
}

protocol SomeClassOnlyProtocol: AnyObject, Rakudo {
  var text: String { get }
}

class Person {
  var name: String
  var age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

extension Person: SomeClassOnlyProtocol {
  var star: String {
    return "\(self.name) is \(self.age) years old"
  }

  var text: String {
    return """
    Person(name = \(self.name), age = \(self.age))
    """
  }
}

let tom = Person(name: "Tom", age: 18)
print(tom.star)
print(tom.text)
