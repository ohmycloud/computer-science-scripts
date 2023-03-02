struct Position: Equatable, Hashable {
    var x: Int
    var y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

let avaiablePositions = [Position(0, 0), Position(0, 1), Position(1, 0)]
let gemPosition = Position(1, 0)

for position in avaiablePositions {
    if position == gemPosition {
        print("Equatable")
    }
}
