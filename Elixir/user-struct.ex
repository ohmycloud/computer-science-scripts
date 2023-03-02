# define a struct with default value for fields
defmodule User do
  defstruct name: "Larry Wall", age: 27, date: ~D[2021-12-11]
end

# define a struct with nil value for fields
defmodule YetAnotherUser do
  defstruct name: nil, age: nil
end

# define a struct and not specify values for fields
defmodule Yet do
  defstruct [:name, :age]
end

# patern Match
%User {age: age, name: name} = %User{ name: "Larry Wall", age: 27 }
IO.puts(name)


# defaine a struct with a enforced key
defmodule User do
  @enforce_keys [:make]
  defstruct [:model, :make]
end
