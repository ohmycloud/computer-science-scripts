enum ServerResponse {
    case result(String, String)
    case failure(String)
    case omm(Int)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Go home")
let omm = ServerResponse.omm(42)

switch omm {
    case let .result(sunrise, sunset):
      print("Sunrise is as \(sunrise) and sunset is at \(sunset)")
    case let .failure(message):
      print("Failure with \(message)")
    case let .omm(number):
      print("Got \(number)")        
}