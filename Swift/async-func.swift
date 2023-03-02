import _Concurrency

func helloPauseGoodbye() async throws {
  print("Hello")
  try await Task.sleep(nanoseconds: 1_000_000_000)
  print("Goodbye")
}

Task {
  try await helloPauseGoodbye()
}
