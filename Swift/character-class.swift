import _StringProcessing
import RegexBuilder

let text = "My #name is #sanjeec and I am an #engineeer with #10 years of #experience"
let regexPattern = Regex {
  "#"
  Capture {
    OneOrMore {
      CharacterClass(
        ("a" ... "z"),
        ("0" ... "9")
      )
    }
  }
}

let matches = text.matches(of: regexPattern)
for match in matches {
  let hashTag = text[match.range.lowerBound..<match.range.upperBound]
  print("hashTag \(hashTag)")
}