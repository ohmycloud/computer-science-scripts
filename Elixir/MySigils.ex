@doc """
Custom Sigils
~i(1)
~i(10)
~i(-10)
"""
defmodule MySigils do
  def sigil_i(string, []), do: String.to_integer(string)
  def sigil_i(string, [?n]), do: -String.to_integer(string) + 100
end
