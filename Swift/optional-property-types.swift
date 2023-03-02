class SurveyQuestion {
  var text: String
  var response: String?
  init(text: String) {
    self.text = text
  }
  func ask() {
    print(text)
  }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "yes, I do like cheese!"

if let someText = cheeseQuestion.response {
  print(someText)
}
