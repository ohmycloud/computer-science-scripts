// Structures that have only stored properties that conform to the Equatable protocol
// Enumerations that have only associated types that conform to the Equatable protocol
// Enumerations that have no associated types

struct Vector3D: Equatable {
  var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)

if twoThreeFour == anotherTwoThreeFour {
  print("These two vectors are also equivalent.")
}

// Structures that have only stored properties that conform to the Hashable protocol
// Enumerations that have only associated types that conform to the Hashable protocol
// Enumerations that have no associated types

enum SkillLevel: Comparable {
  case beginner
  case intermediate
  case expert(stars: Int)
}

var levels = [SkillLevel.intermediate, SkillLevel.beginner, SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
  print(level)
}






















