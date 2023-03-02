import RegexBuilder
import _StringProcessing

enum TransactionKind: String {
    case credit = "CREDIT"
    case debit = "DEBIT"
}

struct Date {
    var month, day, year: Int
    // Failable Initializers
    init?(mmddyyyy: String) {
        if mmddyyyy.count != 8 { return nil }
        let indexOfMonth = mmddyyyy.index(mmddyyyy.startIndex, offsetBy: 2)
        let indexOfDay = mmddyyyy.index(indexOfMonth, offsetBy: 2)
        let indexOfYear = mmddyyyy.index(indexOfDay, offsetBy: 4)
        month = Int(mmddyyyy[..<indexOfMonth])!
        day = Int(mmddyyyy[indexOfMonth..<indexOfDay])!
        year = Int(mmddyyyy[indexOfDay..<indexOfYear])!
    }
}

struct Amount {
    var valueTimes100: Int
    init?(twoDecimalPlaces text: Substring) {
        if String(text).count == 0 { return nil }
        valueTimes100 = Int(Double(text)! * 100)
    }
}

let statementPattern = Regex {
    // 解析交易类型
    TryCapture {
        ChoiceOf {
            "CREDIT"
            "DEBIT"
        }
    } transform: {
        TransactionKind(rawValue: String($0))
    }
    OneOrMore(.whitespace)
    // 解析日期
    TryCapture {
        Repeat(.digit, count: 2)
        Repeat(.digit, count: 2)
        Repeat(.digit, count: 4)
    } transform: {
        Date(mmddyyyy: String($0))
    }
    OneOrMore(.whitespace)
    // 解析交易描述信息
    Capture {
        OneOrMore(CharacterClass(.word, .whitespace))
        CharacterClass.word
    } transform: { String($0) }
    OneOrMore(.whitespace)
    "$"
    // 解析金额
    TryCapture {
        OneOrMore(.digit)
        "."
        Repeat(.digit, count: 2)
    } transform: {
        Amount(twoDecimalPlaces: $0)
    }
}

let input = """
CREDIT    04062020    PayPal transfer    $4.99
CREDIT    04032020    Payroll            $69.73
DEBIT     04022020    ACH transfer       $38.25
DEBIT     03242020    IRS tax payment    $52249.98
"""

for match in input.matches(of: statementPattern) {
    let (_, kind, date, description, amount) = match.output
    print(kind, date, description, amount)
}