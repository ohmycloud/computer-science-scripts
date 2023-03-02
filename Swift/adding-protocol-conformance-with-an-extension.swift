// You can extend an existing type to adopt and conform to a new protocol
// even if your don't have access to the source code for the existing type
// extensions can add new properties, methods, and subscripts to an existing type
protocol TextRepresentable {
  var textualDescription: String { get }
}

extension Int: TextRepresentable {
  var textualDescription: String {
    return "This is " + String(self) 
  }
}

let aInt = 19.textualDescription
print("\(aInt)")
