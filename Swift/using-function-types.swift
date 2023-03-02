func addTwoInts(_ a: Int, _ b: Int) -> Int {
    a + b
}

func multyTwoInts(_ x: Int, _ y: Int) -> Int {
    x * y
}

var mathFunction: (Int, Int) -> Int = addTwoInts
mathFunction = multyTwoInts

print(mathFunction(3, 7))
