import Foundation

let handle = FileHandle.standardInput

for try await line in handle.bytes.lines {
  print(line)
}
