import polars as pl

# read csv
df = pl.read_csv("https://j.mp/iriscsv")
print(df[df["sepal_length"] > 5].groupby("species").sum())

# 转换为 Pandas DataFrame
pdf = pl.read_csv("iris.csv", rechunk=False).to_pandas()
print(type(pdf)) # <class 'pandas.core.frame.DataFrame'>

# write to csv
df = pl.DataFrame({
    "foo": [1, 2, 3],
    "bar": [None, "egg", "spam"],
    "baz": [1.0, 2.4, 4.7]
})

df.to_csv("polars.csv")

# write to parquet
df.to_parquet("path.parquet")

# read parquet
df = pl.read_parquet("path.parquet")
print(df)

# lazy DataFrame

res = (pl.scan_csv("iris.csv")
     .filter(pl.col("sepal_length") > 5)
     .groupby("species")
     .agg(pl.col("*").sum())
).collect()

print(res)