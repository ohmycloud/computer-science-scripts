func replaceNils<K, V>(
  from dictionary: [K: V?],
  with element: V) -> [K:V] {

  dictionary.compactMapValues {
    $0 == nil ? element : $0
  }
}

let dict: [String: Int?] = ["Ra": 6, "Zh": nil, "Am": 8]
let filledDict = replaceNils(from: dict, with: 0)
print(filledDict)
