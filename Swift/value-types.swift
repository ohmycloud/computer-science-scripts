// arrays and dictionaries—are value types, 
//  and are implemented as structures behind the scenes
var array: [String] = ["Raku", "Do", "Swift"]
var dict: [Int:String] = [1: "east", 2: "west", 3: "south"]

let array2 = array
array[0] = "Rakudo"
print(array2)

let dict2 = dict
dict[1] = "north"
print(dict2)
