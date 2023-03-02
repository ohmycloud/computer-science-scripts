import RegexBuilder
import _StringProcessing

// https://forums.swift.org/t/swift-5-7-on-cmd-line-cant-seem-to-find-5-7-regex-class/58625/2
let word = OneOrMore(.word)
let emailPattern = Regex {
    Capture {
        ZeroOrMore {
            word
            "."
        }
        word
    }
    "@"
    Capture {
        word
        OneOrMore {
            "."
            word
        }
    }
}


let text = "My email is my.name@example.com."

if let match = text.firstMatch(of: emailPattern) {
    let (wholeMatch, name, domain) = match.output
    // wholeMatch is "my.name@example.com"
    // name is "my.name"
    // domain is "example.com"
    print(wholeMatch)
    print(name)
    print(domain)
}