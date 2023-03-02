let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber)
{ print(type(of: valueMaintained)) }

if let valueChanged = Int(exactly: pi)
{print(valueChanged)}

if Int(exactly: pi) == nil {
  print("nil")
}
