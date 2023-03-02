struct Animal {
  let species: String
  init?(species: String) {
    if species.isEmpty { return nil }
    self.species = species
  }
}

let animal = Animal(species: "")
if let a = animal {
  print(a)
} else {
  print("nil")
}
