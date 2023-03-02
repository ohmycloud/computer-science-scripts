// Even though the text property is now a constant, it can still be set within the class’s initializer
class SurveyQuestion {
  let text: String
  var response: String?
  init(text: String) {
    self.text = text
  }

  func ask() {
    print(text)
  }
}

let beetsQuestion = SurveyQuestion(text: "HOw about beets?")
beetsQuestion.ask()
beetsQuestion.response = "Rakudo"
