using DataFrames, CSV

df = DataFrame(CSV.File("source.csv"))
CSV.write("test.csv", df)

# or use |> pipline
df |> CSV.write("test2.csv")