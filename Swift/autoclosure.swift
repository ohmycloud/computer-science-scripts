var names = ["Raku", "Do", "Star", "MoarVM", "Dolphinscheduler"]

func serve(name customProvider: @autoclosure () -> String) -> String {
    return "Name is \(customProvider()) 哈哈"
}

let name = serve(name: names.remove(at: 0))
print(name)
