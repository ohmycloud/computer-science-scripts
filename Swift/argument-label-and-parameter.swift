func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown). ==> \(from)"
}

let res = greet(person: "Rest", from: "rooo")
print(res)
