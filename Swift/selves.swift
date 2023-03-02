class Networker {
  class func iwhoAmI() -> Networker.Type {
    return self
  }
}

//Networker.iwhoAmI()

class WebsocketNetworker: Networker {
  class func whoAmI() -> Networker.Type {
     return self
  }
}

let type: Networker.Type = WebsocketNetworker.whoAmI()
print(type)

let networkerType: Networker.Type = Networker.self
print(networkerType)

protocol Request {
   func whoAmI()
}

extension Request {
  func whoAmI() {
    print(Self.self)
  }
}

struct TextRequest: Request {
  
}

TextRequest().whoAmI()




















