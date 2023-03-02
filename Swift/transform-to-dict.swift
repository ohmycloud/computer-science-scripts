import _StringProcessing
import RegexBuilder

// 把解析得到的年份和多个温度值放到这个字典中
var obDict : [Int : Array<Float>] = [:]

let temp = Regex {
    Optionally { "-" }
    OneOrMore(.digit)
    "."
    OneOrMore(.digit)
}

let observation = Regex {
    TryCapture {
      TryCapture {
          OneOrMore(.digit)
      } transform: { Int($0)! }
      OneOrMore {
         Regex {
           OneOrMore(.whitespace)
           TryCapture { temp } transform: { Float($0)! }
         }
      }
    } transform: {
      print($1, $2)
    }
    ZeroOrMore(.whitespace)
}

let observations = Regex {
  OneOrMore {
    "Obs:"
    ZeroOrMore(.whitespace)
    Capture { OneOrMore { observation } }
  }
}

let input = """
Obs:
1921 -4.4 -7.1 -6.8 -4.3 -0.8  2.2  4.7  5.8  2.7 -2.0 -2.1 -4.0
1922 -0.9 -1.7 -6.2 -3.7 -1.6  2.9  4.8  6.3  2.7 -0.2 -3.8 -2.6
2008 -2.8 -2.7 -4.6 -1.8  1.1  3.3  6.1  6.9  5.8  1.2 -3.5 -0.8
2009 -2.3 -5.3 -3.2 -1.6  2.0  2.9  6.7  7.2  3.8  0.6 -0.3 -1.3
"""

for match in input.matches(of: observations) {
    let (_, x, year, temp) = match.output
    print(x, type(of:year), type(of:temp))
    //print(match)
}

print(obDict)