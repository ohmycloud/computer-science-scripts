import _StringProcessing
import RegexBuilder

let transactionPattern = Regex {
  Capture {
    ChoiceOf {
      "CREDIT"
      "DEBIT"
    }
  }
  OneOrMore(.whitespace)
  Capture {
    Regex {
      Repeat(count: 2) {
        One(.digit)
      }
      "/"
      Repeat(count: 2) {
        One(.digit)
      }
      "/"
      Repeat(count: 4) {
        One(.digit)
      }
    }
  }
  OneOrMore(.whitespace)
  Capture {
    Regex {
      OneOrMore {
        CharacterClass(
          .word,
          .whitespace,
          "'",
          "."
        )
      }
      One(.word)
    }
  }
  OneOrMore(.whitespace)
  Capture {
      ChoiceOf {
        "$"
        "£"
      }
      OneOrMore {
        CharacterClass(
          .digit,
          ",",
          "."
        )
      }
    }
}

let text = """
CREDIT    03/01/2022    Payroll from employer      $200.23
CREDIT    03/03/2022    Suspect A                  $2,000,000.00
DEBIT     03/03/2022    Ted's Pet Rock Sanctuary   $2,000,000.00
DEBIT     03/05/2022    Doug's Dugout Dogs         $33.27
DEBIT     06/03/2022    Oxford Comma Supply Ltd.   £57.33
"""

for match in text.matches(of: transactionPattern) {
  let (_, kind, date, institution, amount) = match.output
  print(kind, date, institution, amount)
}