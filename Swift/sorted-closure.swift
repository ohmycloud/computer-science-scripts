let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
reversedNames = names.sorted(by: { (a, b) in
  a > b
})

reversedNames = names.sorted(by: {(a, b) in return a > b})
reversedNames = names.sorted(by: { a, b in return a > b })

// Implicit Returns from Single-Expression Closures
reversedNames = names.sorted(by: { a, b in a > b })

// Shorthand Argument Names
reversedNames = names.sorted(by: { $0 > $1 })

// Operator Methods
reversedNames = names.sorted(by: >)

// Trailing Closures
// When you use the trailing closure syntax, 
// you don’t write the argument label for 
//   the first closure as part of the function call
reversedNames = names.sorted() { 
  $0 > $1
}

// If a closure expression is provided as the function’s or method’s only argument 
// and you provide that expression as a trailing closure, 
// you don’t need to write a pair of parentheses () after the function or method’s name when you call the function
reversedNames = names.sorted { $0 > $1 }
print(reversedNames)

let numbers = [-1, 3, 6, 8, 9, 99, 102, 5, 44]
let sortedNames = numbers.sorted(by: { (x: Int, y: Int) -> Bool in
  return x > y
})

print(sortedNames)
