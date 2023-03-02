# Comprehensions
dt_range = Date.range(~D[2021-12-22], ~D[2021-12-25])
for d <- dt_range, do: IO.puts(d)

# keyword list
value = [good: 1, bad: 2, good: 3, bad: 4, good: 5]

for {:good, n} <- value, do: n * n


# filter
for n <- 1..10, rem(n, 2) == 0, do: n * n


dirs = ['/home/mikey', '/home/james']

for dir <- dirs,
    file <- File.ls!(dir),
    path = Path.join(dir, file),
    File.regular?(path) do
  File.stat!(path).size
end
