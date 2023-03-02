    indirect enum ArithmeticExpression {
        case number(Int)
        case addition(ArithmeticExpression, ArithmeticExpression)
        case multiplication(ArithmeticExpression, ArithmeticExpression)
    }


    let five = ArithmeticExpression.number(5)
    let four = ArithmeticExpression.number(4)
    let sum  = ArithmeticExpression.addition(five, four)
    let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
    print(product)

    func evaluate(_ expression: ArithmeticExpression) -> Int {
      switch expression {
        case let .number(value):
          return value
        case let .addition(left, right):
          return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
          return evaluate(left) * evaluate(right)
      }
    }
    
    let res = evaluate(product)
    print(res)
