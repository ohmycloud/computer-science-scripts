func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int)  -> Int { input + 1 }
    func stepBackward(input: Int) -> Int { input - 1 }

    // body 只有一个句子的时候, 才能省略 return
    return backward ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
while currentValue != 0 {
  print("\(currentValue)...")
  currentValue = moveNearerToZero(currentValue)
}
print("zero!")
