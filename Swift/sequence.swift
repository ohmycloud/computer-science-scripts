let countDownFrom5 = sequence(first: 5) { value in
  value - 1 >= 0 ? value - 1 : nil
}

for value in countDownFrom5 {
    print(value)
}
