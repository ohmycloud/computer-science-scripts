user = %{id: 1, name: "John", email: "john@example.com", active: true}
function_call_result = {:ok, user}

res = case function_call_result do
  {:ok, %{email: email}} -> "Sending email to: #{email}"
  _other -> "Nothing to do"
end

#=> "Sending email to: john@example.com"
IO.inspect function_call_result

IO.inspect(res)
