struct Position: Equatable, Hashable {
    var x: Int
    var y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

class Player {
    var name: String
    var position: Position

    init(name: String, position: Position) {
        self.name = name
        self.position = position
    }
}

extension Player: Equatable {
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.position == rhs.position
    }
}

extension Player: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(position)
    }
}
