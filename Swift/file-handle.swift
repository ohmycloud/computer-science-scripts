import Foundation

let file = FileHandle(forWritingAtPath: "a.txt")!
let lines = ["x,y", "1,1", "2,4", "3,9", "4,16"]

lines.forEach { line in
  file.write("\(line)\n".data(using: .utf8)!)
}

file.closeFile()
