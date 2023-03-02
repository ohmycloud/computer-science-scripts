import _StringProcessing
import RegexBuilder
import Foundation

let text = """
CREDIT  03/02/2022  Payroll from employer       $200.23
CREDIT  03/03/2022  Suspect A                   $2,000,000.00
DEBIT   03/03/2022  Ted's Pet Rock Sanctuary    $2,000,000.00
DEBIT   03/05/2022  Doug's Dugout Dogs          $33.27
"""

let fieldSeparator = OneOrMore(.whitespace);

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

  // non-capture
  "$"

  Capture {
    OneOrMore(.digit) // d+
    ChoiceOf { // '.' | ','
      "." 
      ","
    }
    Repeat(.digit, count: 2) // d{2}
  }
}

if let match = text.firstMatch(of: transactionMatcher) {
    print(match.output)
}