func replaceNilValues<T>(from array: [T?], with element: T) -> [T] {
    array.compactMap {
      $0 == nil ? element : $0
    }
}

let numbers: [Int?] = [32, 3, 24, nil, 4]
let filledNumbers = replaceNilValues(from: numbers, with: 0)
print(filledNumbers)

let strings: [String?] = ["A", "B", nil, "D", "E"]
let filledString = replaceNilValues(from: strings, with: "")
print(filledString)
