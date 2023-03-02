data = %{
  important_flag: true,
  level_1: %{
    other: "stuff",
    level_2: %{
      value: 123,
      more: "stuff"
    }
  }
}

case data do
  %{important_flag: false} -> {:ok, 0}
  %{important_flag: true, level_1: %{level_2: %{value: value}}} -> {:ok, value}
  _other -> {:error, "Invalid data"}
end
