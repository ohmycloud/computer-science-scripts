protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    let test: Int

    func adjust() {
        simpleDescription += "New 100% adjuested"
    }

    func gist() -> String {
        return "From Perl6"
    }

    init(test: Int) {
        self.test = test
    }
}

let aAimpleClass = SimpleClass(test: 12)
aAimpleClass.adjust()
let aSimpleDescription = aAimpleClass.simpleDescription
print(aSimpleDescription)
aAimpleClass.anotherProperty = 3386
print(aAimpleClass.anotherProperty)
print(aAimpleClass.test)


struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjuested)"
    }
}

var b = SimpleStructure()
b.adjust()
print(b.simpleDescription)

let protocolValue: ExampleProtocol = aAimpleClass
print(protocolValue.simpleDescription + " from protocol value")

//  When you work with values whose type is a protocol type,
//    methods outside the protocol definition aren’t available
// print(protocolValue.anotherProperty) // anotherProperty not available
// print(protocolValue.gist())          // method `gist()` not available