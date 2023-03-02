import Dispatch

let queue = DispatchQueue(label: "com.example.queue")

func now(_ closure: () -> Void) {
  closure()
}

func later(_ closure: @escaping () -> Void) {
  queue.asyncAfter(deadline: .now() + 2) {
    closure()
  }
}

later {
  print("A")
}
print("B")

now {
  print("C")
}
print("D")

let semaphore = DispatchSemaphore(value: 0).wait(timeout: .now() + 10)
