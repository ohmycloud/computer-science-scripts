// Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.

struct Size {
  var width = 0.0, height = 0.0
}

let s = Size(width: 1.0, height: 3.0)
print(s)

let omit = Size(width: 5.0)
print(omit)
