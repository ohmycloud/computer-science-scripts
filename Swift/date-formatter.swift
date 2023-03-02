import Foundation

let format = DateFormatter()
   format.timeZone = .current
   format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"        
   let dateString = format.string(from: Date())
print(dateString)
