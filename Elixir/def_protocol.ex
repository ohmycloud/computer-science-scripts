# define a protocol with a method named type
defprotocol Utility do
  @spec type(t) :: String.t()
  def type(value)
end

# implement the defined protocol for type BitString
defimpl Utility, for: BitString do
  def type(_value), do: "string"
end

# implement the defined protocol for type Integer
defimpl Utility, for: Integer do
  def type(_value), do: "integer"
end


# define a struct with default value for fields
defmodule User do
  defstruct name: "Larry Wall", age: 27, date: ~D[2021-12-11]
end

# implement the defined protocol for type User
defimpl Utility, for: User do
  def type(_value), do: "struct"
end


Utility.type(123)      # integer
Utility.type("foo")    # string
Utility.type(%User {}) # struct

defimpl String.Chars, for: User do
  def to_string(s), do: ~s"#{s.name} is #{s.age} years old"
end

# call to_string on struct
String.Chars.to_string(%User{})

# loopup implemented protocols on User struct
i %User{}

# Implemented protocols
#   IEx.Info, Inspect, String.Chars
