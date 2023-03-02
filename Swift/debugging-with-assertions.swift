let age = 3
assert(age <= 0, "A person's age can't be less than zero", file: "a.txt", line: 12)
print(age)

    if age > 10 {
        print("You can ride the roller-coaster or the ferris wheel.")
    } else if age >= 0 {
        print("You can ride the ferris wheel.")
    } else {
        assertionFailure("A person's age can't be less than zero.")
    }

precondition(age < 0, "Index must be greater than zero.")
print("OK")
