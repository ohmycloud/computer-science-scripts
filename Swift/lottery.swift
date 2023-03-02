enum Lottery {
    static var lotteryWinHandler: (() -> Void)?


    @discardableResult static func pickWinner(guess: Int) -> Bool {
        print("Running the lottery.")
        if guess == Int.random(in: 0 ..< 100_000_000), let winHandler = lotteryWinHandler {
            winHandler()
            return true
        }


        return false
    }
}

func payBills() {
    amountOwed = 0
}


var amountOwed = 25
let myLuckyNumber = 42


Lottery.lotteryWinHandler = {
    print("Congratulations!")
    payBills()
}


// You get 10 chances at winning.
for _ in 1...10 {
    Lottery.pickWinner(guess: myLuckyNumber)
}


if amountOwed > 0 {
    fatalError("You need to pay your bills before proceeding.")
}
