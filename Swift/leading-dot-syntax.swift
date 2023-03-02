class C {
    static let zero = C(0)
    var x: Int

    init(_ x: Int) {
        self.x = x
    }
}

func f(_ c: C) {
    print(c.x)
}

f(.zero) // prints '0'

extension C {
    var incremented: C {
        return C(self.x + 1)
    }
}

f(.zero.incremented)
