    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    }

    enum CompassPoint: String {
        case north, south, east, west
    }

    enum Point: Float {
        case a = 1.0, b = 2.0, c = 3.0
    }

    let earth = Planet.earth
    let east = CompassPoint.east
    let c = Point.c
     
    print(earth.rawValue)
    print(east.rawValue)
    print(c.rawValue)

    let jupiter = Planet(rawValue: 5)
    print(type(of: jupiter))
    func return_early_in_guard(e: Planet?) -> String? {
        guard let jup = e else {
            print("jupiter is lost")
            return nil
        }
        return String(jup.rawValue)
    }
    let res = return_early_in_guard(e: jupiter)
    if let r = res {
      print(r)
    }

