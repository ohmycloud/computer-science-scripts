struct Color {
  let red, green, blue: Double
  init(red: Double, green: Double, blue: Double) {
    self.red = red
    self.green = green
    self.blue = blue
  }

  init(white: Double) {
    red = white
    green = white
    blue = white
  }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
print(magenta.red)
print(halfGray.red)
