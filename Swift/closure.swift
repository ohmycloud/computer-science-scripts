let numbers = 1 ... 20
let threefold = numbers.map( { number in
  3 * number
})
print(threefold)

let sorted = numbers.sorted { $0 > $1 }
for i in sorted {
  print(i)
}
