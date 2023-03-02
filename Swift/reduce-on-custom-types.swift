struct Score {
  var wins = 0, draws = 0, losses = 0
  var goalsScored = 0, goalsReceived = 0
  init() {}

  init(goalsScored: Int, goalsReceived: Int) {
    self.goalsScored = goalsScored
    self.goalsReceived = goalsReceived

    if goalsScored == goalsReceived {
      draws = 1
    } else if goalsScored > goalsReceived {
      wins = 1
    } else {
     losses = 1
    }
  }
}

extension Score {
  static func +(left: Score, right: Score) -> Score {
    var newScore = Score()
    newScore.wins = left.wins + right.wins
newScore.losses = left.losses + right.losses
newScore.draws = left.draws + right.draws
newScore.goalsScored =
left.goalsScored + right.goalsScored
newScore.goalsReceived =
left.goalsReceived + right.goalsReceived
return newScore
  }
}

var teamScores = [
Score(goalsScored: 1, goalsReceived: 0),
Score(goalsScored: 2, goalsReceived: 1),
Score(goalsScored: 0, goalsReceived: 0),
Score(goalsScored: 1, goalsReceived: 3),
Score(goalsScored: 2, goalsReceived: 2),
Score(goalsScored: 3, goalsReceived: 0),
Score(goalsScored: 4, goalsReceived: 3)
]

let firstSeasonScores = teamScores.reduce(Score(), +)
print(firstSeasonScores)

var secondSeasonMatches = [
Score(goalsScored: 5, goalsReceived: 3),
Score(goalsScored: 1, goalsReceived: 1),
Score(goalsScored: 0, goalsReceived: 2),
Score(goalsScored: 2, goalsReceived: 0),
Score(goalsScored: 2, goalsReceived: 2),
Score(goalsScored: 3, goalsReceived: 2),
Score(goalsScored: 2, goalsReceived: 3)
]
let totalScores = secondSeasonMatches.reduce(firstSeasonScores,+)
print(totalScores)

func areMatchesSorted(first: Score, second: Score) -> Bool {
  if first.wins != second.wins {
    return first.wins > second.wins
  } else if first.draws != second.draws {
    return first.draws > second.draws
  } else {
    let firstDifference = first.goalsScored -
first.goalsReceived
let secondDifference = second.goalsScored -
second.goalsReceived
if firstDifference == secondDifference {
return first.goalsScored > second.goalsScored
} else {
return firstDifference > secondDifference
}
  }
}


let res2 = secondSeasonMatches.sorted(by: areMatchesSorted(first:second:))
print(res2)

























