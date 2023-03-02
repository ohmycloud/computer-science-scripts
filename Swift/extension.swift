protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

var aInt = 8
aInt.adjust()
print(aInt)

print(1.simpleDescription)


