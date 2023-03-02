import RegexBuilder
import _StringProcessing

let statementPattern = Regex {
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
      Repeat(count: 2) {
        One(.digit)
      }
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
          .whitespace
        )
      }
      One(.word)
    }
  }
  OneOrMore(.whitespace)
  Capture {
    Regex {
      "$"
      OneOrMore(.digit)
      "."
      Repeat(count: 2) {
        One(.digit)
      }
    }
  }
}

let statement = """
  CREDIT    04062020    PayPal transfer    $4.99
  CREDIT    04032020    Payroll            $69.73
  DEBIT     04022020    ACH transfer       $38.25
  DEBIT     03242020    IRS tax payment    $52249.98
"""

for match in statement.matches(of: statementPattern) {
  let (line, kind, date, description, amount) = match.output
  print(kind, date, description, amount)
}