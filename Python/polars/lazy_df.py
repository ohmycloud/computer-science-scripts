# -*- coding: utf-8 -*-

import polars as pl
from polars import col,lit

df = pl.DataFrame(
    {
        "a": [1,2,3],
        "b": [4,5,6]
    }
)

ldf = df.lazy().with_column(lit(1).alias("foo")).select([col("a"), col("foo")])
print(ldf)

# 调用 collect 的时候才会真正执行计算
print(ldf.collect())