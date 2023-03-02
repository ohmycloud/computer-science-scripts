func aHigherOrderFunction(_ operation: (Int) -> ()) {
  let numbers = 1...10
  numbers.forEach(operation)
}

func someOperation(_ p1: Int, _ p2: String) {
  print("number is \(p1), and String is: \(p2)")
}

/*
func curried_SomeOperation(_ p1: Int) -> ((String) -> ()) {
  return { str in
    print("number is: \(p1), and String is \(str)")
  }
}
*/
func curried_SomeOperation(_ str: String) -> (Int) -> () {
  return { p1 in
    print("number is: \(p1), and String is \(str)")
  }
}

//aHigherOrderFunction { someOperation($0, "a constant") }
//aHigherOrderFunction { curried_SomeOperation("a constant value")($0) }

aHigherOrderFunction(curried_SomeOperation("a constant value"))
