protocol SomeProtocol {
  //init(someParameter: Int)
  init()
}

class SomeSuperClass {
  init() {

  }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
  required override init() {
  
  }
}

