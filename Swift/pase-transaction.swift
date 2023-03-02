import _StringProcessing
import RegexBuilder
import Foundation

let text = """
CREDIT  03/02/2022  Payroll from employer       $200.23
DEBIT   03/05/2022  Doug's Dugout Dogs          $33.27
"""

let fieldSeparator = OneOrMore(.whitespace)

let transactionMatcher = Regex {
  Capture {
    ChoiceOf {
      "CREDIT"
      "DEBIT"
    }
  }

  fieldSeparator

  Capture {
    Repeat(.digit, count: 2)
    "/"
    Repeat(.digit, count: 2)
    "/"
    Repeat(.digit, count: 4)
  }

  fieldSeparator

  Capture {
    OneOrMore {
      NegativeLookahead { fieldSeparator }
      CharacterClass.any
    }
  }

  fieldSeparator

  "$"
  
  // Parse the amount, e.g. `$100.00`.
  Capture {
    OneOrMore(.digit)
    "."
    Repeat(.digit, count: 2)
  }
}

for match in text.matches(of: transactionMatcher) {
    let (_, kind, date, desription, amout) = match.output
    print(kind, date, desription, amout)
}