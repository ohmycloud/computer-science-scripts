data = %{language: "Rakudo", release: "6", items: %{pugs: %{name: "Andery", age: 39}, moar: %{name: "jhthn", age: 32}}}

IO.inspect data

res = case data do
  %{language: _} -> "Rakudo"
  %{release: version} -> "version #{inspect version} released."
  %{items: %{pugs: %{name: name} }} -> "Hello #{name}"
  _ -> "unknow"
end

IO.inspect res
