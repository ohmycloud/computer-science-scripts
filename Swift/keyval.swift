import RegexBuilder
import _StringProcessing

let keyval = Regex {
  Capture {
    OneOrMore(.any, .reluctant)
  }
  Lookahead {"="}
  OneOrMore(.whitespace)
  Capture {
    OneOrMore(.any)
  }
  ZeroOrMore(.whitespace)
}

let keyvalPattern = Regex {
    OneOrMore { keyval }
    ZeroOrMore(.whitespace)
}

let input = """
Name= Jan Mayen
Country= NORWAY
Lat=   70.9
Long=    8.7
Height= 10
Start year= 1921
End year= 2009
"""

for match in input.matches(of: keyvalPattern) {
    let (_, key, value) = match.output
    print(key, value)
}