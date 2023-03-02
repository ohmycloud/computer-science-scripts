import Combine
import Foundation

protocol Greetable {
  func greet() -> String
}

extension Greetable {
  func greet() -> String {
    return "Hello"
  }
  func leave() -> String {
    return "Bye"
  }
}

struct GermanGreeter: Greetable {
  func greet() -> String {
    return "Hallo"
  }
  func leave() -> String {
    return "Tschüss"
  }
}

struct ChineseGreeter: Greetable {
  func greet() -> String {
    return "你好"
  }
}

let greeter: Greetable = GermanGreeter()
let chineseGreeter: Greetable = ChineseGreeter()
//print(greeter.greet())
//print(greeter.leave())

//print(chineseGreeter.greet())

let arrayOfGreetable: [Greetable] = [greeter, chineseGreeter]
for g in arrayOfGreetable {
  print(g.greet())
}

// compose multi protocols
extension Array where Element: Greetable {
  var allGreetings: String {
    self.map { $0.greet() }.joined()
  }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

protocol Request {
  var url: URL { get }
  var method: HTTPMethod { get }
}

struct ArticleRequest: Request {
  var url: URL {
    let baseURL = "https://api.raywenderlich.com/api"
    let path = "/contents?filter[content_types][]=article"
    return URL(string: baseURL + path)!
  }

  var method: HTTPMethod { return .get }
}


class Networker {
  func fetch(_ request: Request) -> AnyPublisher<Data, URLError> {
    var urlRequest = URLRequest(url: request.url)
    urlRequest.httpMethod = request.method.rawValue
    
    return URLSession.shared
      .dataTaskPublisher(for: urlRequest)
      .compactMap { $0.data }
      .eraseToAnyPublisher()
  }
}


























