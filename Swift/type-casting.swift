// is 
// as

// Define a ClassHierachy for Type Casting
class MediaItem {
  var name: String
  init(name: String) {
    self.name = name
  }
}

class Movie: MediaItem {
  var director: String
  init(name: String, director: String) {
    self.director = director
    super.init(name: name)
  }
}

class Song: MediaItem {
  var artist: String
  init(name: String, artist: String) {
    self.artist = artist
    super.init(name: name)
  }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]


print(type(of: library))

var movieCount = 0
var songCount = 0

for item in library {
  if item is Movie {
    movieCount += 1
  } else if item is Song {
    songCount += 1
  }
}

print("There are \(movieCount) movies and there are \(songCount) songs")

// downcasting as? or as!
for item in library {
  if let movie = item as? Movie {
    print("Movie: \(movie.name), dir. \(movie.director)")
  } else if let song = item as? Song {
    print("Song: \(song.name), by \(song.artist)")
  }
}

























