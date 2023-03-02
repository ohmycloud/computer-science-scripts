enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    if printerName == "没纸了" {
        throw PrinterError.outOfPaper
    }
    return "job Send"
}

do {
  let printerResponse = try send(job: 4040, toPrinter: "xx没纸了")
  print(printerResponse)
} catch PrinterError.outOfPaper {
    print("纸张用完了")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError)")
} catch {
    print(error)
}

let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true

    defer {
        fridgeIsOpen = false
    }

    let result = fridgeContent.contains(food)
    return result
}

let res = fridgeContains("banana")
print(res)
print(fridgeIsOpen)