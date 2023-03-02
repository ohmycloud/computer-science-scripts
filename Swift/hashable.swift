struct Position: Equatable, Hashable {
    var x: Int
    var y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

var visitedPositions: Set = [Position(0, 0), Position(1, 0)]
let currentPosition = Position(1, 3)

if visitedPositions.contains(currentPosition) {
    print("Already visited \(currentPosition.x), \(currentPosition.y)")
} else {
    print("First time at \(currentPosition.x), \(currentPosition.y)")
    visitedPositions.insert(currentPosition)
}
