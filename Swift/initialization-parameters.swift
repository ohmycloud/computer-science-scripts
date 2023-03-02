struct Celsius {
  var temperatureInCelsius: Double
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32.0) / 1.8
  }

  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(boilingPointOfWater.temperatureInCelsius)
print(freezingPointOfWater.temperatureInCelsius)
