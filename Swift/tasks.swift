import _Concurrency

let task = Task {
  print("Doing some work on a task")
  let sum = (1...100).reduce(0, +)
  try Task.checkCancellation()
  print("[+] 1...100 = \(sum)")
}

print("Doing some work on the main actor")
task.cancel()
