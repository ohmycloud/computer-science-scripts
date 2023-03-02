let events: [Int] = [1,3,5,7,9,11]
var eventsIterator = events.makeIterator()
while let event = eventsIterator.next() {
  print(event)
}

struct CountdownIterator: IteratorProtocol {
    var count: Int
    mutating func next() -> Int? {
        guard count >= 0 else {
            return nil
        }
        defer { count -= 1}
        return count
    }
}

struct CountDown: Sequence {
    let start: Int
    func makeIterator() -> CountdownIterator {
        CountdownIterator(count: start)
    }
}

for value in CountDown(start: 5) {
    print(value)
}
