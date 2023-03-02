protocol SomeProtocol {
  static func someTypeMethod()
}

protocol RandomNumberGenerator {
  func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
  var lastRandom = 42.0
  let m = 139968.0
  let a = 3877.0
  let c = 29573.0
  
  func random() -> Double {
    lastRandom = ( (lastRandom * a + c)
            .truncatingRemainder(dividingBy: m)
    )
    return lastRandom / m
  }
}

let generator = LinearCongruentialGenerator()
print("随机数: \(generator.random())")
print("另一个随机数: \(generator.random())")

