import polars as pl
from polars import col

path = "legislators-historical.csv"
dtypes = {
    "first_name": pl.Categorical,
    "gender": pl.Categorical,
    "type": pl.Categorical,
    "state": pl.Categorical,
    "party": pl.Categorical,
}

df = pl.read_csv(path, dtype=dtypes)

q = (
    df.lazy()
    .groupby("first_name")
    .agg([pl.count("party"), col("gender").list(), pl.first("last_name")])
    .sort("party_count", reverse=True)
    .limit(5)
)

print(q.collect())

q1 = (
    df.lazy()
    .groupby("state")
    .agg(
        [
            (col("party") == "Anti-Administration").sum().alias("anti"),
            (col("party") == "Pro-Administration").sum().alias("pro"),
        ]
    )
    .sort("pro", reverse=True)
    .limit(5)
)

print(q1.collect())

q2 = (
    df.lazy()
    .groupby(["state", "party"])
    .agg([pl.count("party").alias("count")])
    .filter(
        (col("party") == "Anti-Administration") | (col("party") == "Pro-Administration")
    )
    .sort("count", reverse=True)
    .limit(5)
)

print(q2.collect())
