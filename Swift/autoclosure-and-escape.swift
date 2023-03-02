var languages = ["Zig", "Lua", "Raku", "Star"]
var customProviders: [() -> String] = []

func serve(_ customProvider: @autoclosure @escaping () -> String) -> () {
    customProviders.append(customProvider)
}

serve(languages.remove(at: 0))
serve(languages.remove(at: 0))

for i in customProviders {
  print("\(i())")
}

print(languages)
