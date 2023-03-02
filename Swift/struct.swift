    enum Rank: Int {
        case ace = 1
        case two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king

        func simpleDescription() -> String {
            switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue) + String(" hello")
            }
        }
    }

    enum Suit {
        case spades, hearts, diamonds, clubs

        func color() -> String {
          switch self {
            case .spades, .clubs:
                return "black"
            case .hearts, .diamonds:
                return "red"
          }
        }

        func simpleDescription() -> String {
            switch self {
            case .spades:
                return "spades"
            case .hearts:
                return "hearts"
            case .diamonds:
                return "diamonds"
            case .clubs:
                return "clubs"
            }
        }
    }

struct Card {
    var rank: Rank
    var suit: Suit

    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }

    func fullCards() {
        
    }
}

let threeOfSpades = Card(rank: .three, suit: .spades)
print(threeOfSpades.simpleDescription())