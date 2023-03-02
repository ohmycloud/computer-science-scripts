// You can make a generic type conditionally conform to a protocol by listing constrains when extending the type
// Write these constraints after the name of the protocol you're adopting by writing a generic where clause
    protocol TextRepresentable {
        var textualDescription: String { get }
    }


extension Array: TextRepresentable where Element: TextRepresentable {
  var textualDescription: String {
    let itemAsText = self.map { $0.textualDescription }
    return "[" + itemAsText.joined(separator: ", ") + "]"
  }
}

extension Int: TextRepresentable {
  var textualDescription: String {
    return "This is " + String(self)
  }
}

let aArr = [1,3,5,7,9]
print(aArr.textualDescription)
