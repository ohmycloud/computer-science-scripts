defmodule UrlToken do
  def get_token1(string) do
    parts = String.split(string, "&")
    Enum.find_value(parts, fn pair ->
      key_value = String.split(pair, "=")
      Enum.at(key_value, 0) == "token" && Enum.at(key_value, 1)
    end)
  end
  def get_token2(string) do
    parts = String.split(string, "&")
    Enum.find_value(parts, fn pair ->
      [key, value] = String.split(pair, "=")
      key == "token" && value
    end)
  end
end
