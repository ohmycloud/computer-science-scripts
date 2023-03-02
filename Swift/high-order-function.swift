protocol ParagraphFormatterProtocol {
    func formatParagraph(_ text: String) -> String
}

class TextPrinter {
    var formatter: ParagraphFormatterProtocol
    init(formatter: ParagraphFormatterProtocol) {
        self.formatter = formatter
    }

    func printText(_ paragraphs: [String]) {
        for text in paragraphs {
            let formattedText = formatter.formatParagraph(text)
            print(formattedText)
        }
    }
}

class SimpleFormatter: ParagraphFormatterProtocol {
    func formatParagraph(_ text: String) -> String {
        guard !text.isEmpty else { return text }
        var formattedText = text.prefix(1).uppercased() + text.dropFirst()
        if let lastCharacter = formattedText.last, !lastCharacter.isPunctuation {
            formattedText += "."
        }
        return formattedText
    }
}

let simpleFormatter = SimpleFormatter()
let textPrinter = TextPrinter(formatter: simpleFormatter)
let exampleParagraphs = [
    "basic text example",
    "Another text example!!",
    "one more text example"
]

//textPrinter.printText(exampleParagraphs)

extension Array where Element == String {
    func printFormatted(formatter: ParagraphFormatterProtocol) {
        let textPrinter = TextPrinter(formatter: formatter)
        textPrinter.printText(self)
    }
}

//exampleParagraphs.printFormatted(formatter: simpleFormatter)

func formatParagraph(_ text: String) -> String {
guard !text.isEmpty else { return text }
var formattedText =
text.prefix(1).uppercased() + text.dropFirst()
if let lastCharacter = formattedText.last,
!lastCharacter.isPunctuation {
formattedText += "."
}
return formattedText
}

extension Array where Element == String {
    func printFormatted2(formatter: ( (String) -> String) ) {
        for string in self {
            let formattedString = formatter(string)
            print(formattedString)
        }
    }
}

exampleParagraphs.printFormatted2(formatter: formatParagraph(_:))
