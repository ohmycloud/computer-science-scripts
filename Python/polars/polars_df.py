# -*- coding: utf-8 -*-

import polars as pl
from polars import col,lit

df = pl.DataFrame(
    {
        "A": [1, 2, 3, 4, 5],
        "fruits": ["banana", "banana", "apple", "apple", "banana"],
        "B": [5, 4, 3, 2, 1],
        "cars": ["beetle", "audi", "beetle", "beetle", "beetle"],
    }
)

# embarrassingly parallel execution
# very expressive query language
expressive_df = df.sort("fruits").select([
    "fruits",
    "cars",
    lit("fruits").alias("literal_string_fruits"),
    col("B").filter(col("cars") == "beetle").sum(),
    col("A").filter(col("B") > 2).sum().over("cars").alias("sum_A_by_cars"),       # groups by "cars"
    col("A").sum().over("fruits").alias("sum_A_by_fruits"),                        # groups by "fruits"
    col("A").reverse().over("fruits").flatten().alias("rev_A_by_fruits"),          # groups by "fruits
    col("A").sort_by("B").over("fruits").flatten().alias("sort_A_by_B_by_fruits")  # groups by "fruits"
])

print(df)