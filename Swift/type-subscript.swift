enum Planet: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
  static subscript(n: Int) -> Planet {
    return Planet(rawValue: n)!
  } 
}

let mars = Planet[4]
print(mars)
