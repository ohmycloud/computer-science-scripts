import _StringProcessing
import RegexBuilder

var obDict : [Int : Array<Float>] = [:]
let year = Reference(Substring.self)

let keyval = Regex {
  Capture {
    OneOrMore(.any, .reluctant)
  }
  Lookahead {"="}
  "="
  OneOrMore(.whitespace)
  Capture {
    OneOrMore(.any)
  }
  ZeroOrMore(.whitespace)
}

let keyvalPattern = Regex {
    Capture {
      OneOrMore { keyval }
    }
    ZeroOrMore(.whitespace)
}

let temp = Regex {
    Optionally { "-" }
    OneOrMore(.digit)
    "."
    OneOrMore(.digit)
}

let observation = Regex {
   Capture(as: year) {
        OneOrMore(.digit)
    } //transform: { Int($0)! }
   OneOrMore {
      Regex {
        OneOrMore(.whitespace)
        TryCapture { temp } transform: { Float($0)! }
      }
    }

    ZeroOrMore(.whitespace)
}

let observations = Regex {
  keyvalPattern  
  OneOrMore {
    "Obs:"
    ZeroOrMore(.whitespace)
    Capture { OneOrMore { observation } }
  }
}

let input = """
Name= Jan Mayen
Country= NORWAY
Lat=   70.9
Long=    8.7
Height= 10
Start year= 1921
End year= 2009
Obs:
1921 -4.4 -7.1 -6.8 -4.3 -0.8  2.2  4.7  5.8  2.7 -2.0 -2.1 -4.0
1922 -0.9 -1.7 -6.2 -3.7 -1.6  2.9  4.8  6.3  2.7 -0.2 -3.8 -2.6
2008 -2.8 -2.7 -4.6 -1.8  1.1  3.3  6.1  6.9  5.8  1.2 -3.5 -0.8
2009 -2.3 -5.3 -3.2 -1.6  2.0  2.9  6.7  7.2  3.8  0.6 -0.3 -1.3
"""

for match in input.matches(of: observations) {
  let (_, weather) = match.output
  print(weather)
}