struct Typewriter: AsyncSequence {
 typealias Element = String
 
 let phrase: String
 
 func makeAsyncIterator() -> TypewriterIterator {
 return TypewriterIterator(phrase)
 }
}

struct TypewriterIterator: AsyncIteratorProtocol {
 typealias Element = String
 
 let phrase: String
 var index: String.Index
 
 init(_ phrase: String) {
 self.phrase = phrase
 self.index = phrase.startIndex
 }
 
 mutating func next() async throws -> String? {
 guard index < phrase.endIndex else {
 return nil
 }
 try await Task.sleep(nanoseconds: 1_000_000_000)
 defer {
 index = phrase.index(after: index)
}
 return String(phrase[phrase.startIndex...index])
 }
} 

for try await item in Typewriter(phrase: "Hello, world!") {
 print(item)
}
