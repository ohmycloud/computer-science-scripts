let s1 = "I am not a good painter"
print(s1.ranges(of: /good/))
do {
    let regGood = try Regex("[a-z]ood")
    print(s1.replacing(regGood, with: "bad"))
} catch {
    print(error)
}
print(s1.trimmingPrefix(/i am /.ignoresCase()))

let reg1 = /(.+?) read (\d+) books./
let reg2 = /(?<name>.+?) read (?<books>\d+) books./
let s2 = "Jack read 3 books."
do {
    if let r1 = try reg1.wholeMatch(in: s2) {
        print(r1.1)
        print(r1.2)
    }
    if let r2 = try reg2.wholeMatch(in: s2) {
        print("name:" + r2.name)
        print("books:" + r2.books)
    }
} catch {
    print(error)
}
