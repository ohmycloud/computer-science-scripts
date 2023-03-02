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
    let ace = Rank.nine
    let aceRawValue = ace.rawValue
    print(aceRawValue)
    if let convertedRank = Rank(rawValue: 31) {
        print(convertedRank.simpleDescription())
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
    let hearts = Suit.hearts
    let heartsDescription = hearts.simpleDescription()
    print(hearts.color())
