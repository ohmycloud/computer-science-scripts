import _StringProcessing
import RegexBuilder

// \w+
let word = OneOrMore(.word)

// '-'? \d+
// -?\d+
let integer = Regex {
    Optionally { "-" }
    OneOrMore(.digit)
}

// '-'? \d+ [\.\d+]?
// -?\d+(?:\.\d+)?
let num = Regex {
    Optionally { "-" }
    OneOrMore(.digit)
    Optionally {
        Regex {
          "."
          OneOrMore(.digit)
        }
    }
}

// \w+ [ \s \w+ ]*
// \w+(?:\s\w+)*
let name = Regex {
    OneOrMore(.word)
    ZeroOrMore {
        Regex {
            One(.whitespace)
            OneOrMore(.word)
        }
    }
}

let destination = Regex {
    OneOrMore(.whitespace)
    name
    OneOrMore(.whitespace)
    ":"
    OneOrMore(.whitespace)
    num
    ","
    num
    OneOrMore(.whitespace)
    ":"
    OneOrMore(.whitespace)
    integer
    .anchorsMatchLineEndings()
}

let country = Regex {
    name
    .anchorsMatchLineEndings()
    OneOrMore { destination }
}

let tripPattern = Regex {
    Capture {
      OneOrMore { country }
    }
}


let text = """
Russia
    Vladivostok : 43.131621,131.923828 : 4
    Ulan Ude : 51.841624,107.608101 : 2
    Saint Petersburg : 59.939977,30.315785 : 10
Norway
    Oslo : 59.914289,10.738739 : 2
    Bergen : 60.388533,5.331856 : 4
Ukraine
    Kiev : 50.456001,30.50384 : 3
Switzerland
    Wengen : 46.608265,7.922065 : 3
    Bern : 46.949076,7.448151 : 1
"""

for match in text.matches(of: tripPattern) {
  let (_, trip) = match.output
  print(trip)
}