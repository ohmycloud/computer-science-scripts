# -*- coding: utf-8 -*-

import polars as pl
from polars import col,lit

df = pl.DataFrame(
    {
        "a": [1, 2, 3],
        "b": [1.0, 2.0, 3.0]
    }
)

new_df = df.lazy() \
           .with_column(col("a").map(lambda s: s**s).alias("doubled")) \
           .with_column(lit(1).alias("foo")) \
           .collect()

print(new_df)