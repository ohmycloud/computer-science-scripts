let countDOwnFrom5State = sequence(state: 5) { (state: inout Int) -> Int? in
  defer { state -= 1 }
  return state >= 0 ? state : nil
}

for value in countDOwnFrom5State {
    print(value)
}
