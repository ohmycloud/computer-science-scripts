let countDownFrom5State = sequence(state: 5) { (state: inout Int) -> Int? in 
  defer { state -= 1 }
  return state >= 0 ? state : nil
}

extension Sequence {
    func eraseToAnySequence() -> AnySequence<Element> {
        AnySequence(self)
    }
}

let seq = countDownFrom5State.eraseToAnySequence()

for i in seq {
    print(i)
}

print(type(of: countDownFrom5State))
print(type(of: seq))
