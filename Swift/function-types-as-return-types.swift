func stepForward(_ input: Int) -> Int {
  input + 1
}

func stepBackward(_ input: Int) -> Int {
  input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
  backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
//print(moveNearerToZero(4))

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
