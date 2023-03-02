func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
  print("Result is: \(mathFunction(a, b))")
}

func addTwoInts(_ a: Int, _ b: Int) -> Int {
  a + b
}

func multiTwoInts(_ a: Int, _ b: Int) -> Int {
  a * b
}

printMathResult(addTwoInts, 1,9)
printMathResult(multiTwoInts, 1,9)
