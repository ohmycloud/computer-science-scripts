func calculateStat(_ scores: (key: String, value: Array<Int>)) -> (name: String, min: Int, max: Int, sum: Int) {
  let min = scores.value.min()!
  let max = scores.value.max()!
  let sum = scores.value.reduce(0, +)

  return (name: scores.key, min: min, max: max, sum: sum)
}

let st = [
  "Tom": [1,5,7,12,56,37],
  "Bob": [9,5,3,7,8,34,78],
  "Davi": [6,78,56,78,98],
  "我赌你的枪里没有子弹": [67,65,78,98,23]
]

for (_, value) in st.enumerated() {
    print(calculateStat(value))
}
