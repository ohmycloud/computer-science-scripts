data = %{name: "Howard", age: 35}

res = case data do
  %{name: "Howard"} -> "Yes sir Mr. #{data[:name]}"
  %{name: name} -> "Greeting #{name}!"
  %{age: age} -> "我不知道你是谁, 但是我知道你多大了 #{inspect age}"
  _ -> "unknow"
end

IO.puts res <> " 秦始皇吃花椒"
