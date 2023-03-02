struct Celsius {
  var temperatureInCelsius: Double
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32.0) / 1.8
  }

  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }

  init(_ celsius: Double) {
    temperatureInCelsius = celsius
  }
}

let bodyTemperature = Celsius(37.0)
print(bodyTemperature.temperatureInCelsius)
