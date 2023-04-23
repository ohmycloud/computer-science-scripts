# -*- coding: utf-8 -*-

import polars as pl
from polars import col

# 从 Series 创建 DataFrame
df = pl.DataFrame(
    [
        pl.Series(
            "date",
            [
                    "2021-01-01 00:00:00",
                    "2021-01-01 00:00:00",
                    "2021-01-02 00:00:00",
                    "2021-01-02 00:00:00",
                    "2021-01-03 00:00:00", 
            ],
        ).str.strptime(pl.datatypes.Datetime, '%Y-%m-%d %T'),
        pl.Series("values", [5,4,3,2,1])
    ]
)

out = df.sort(["date", "values"])
print(out)

# 使用 with_column 添加新的列
out = df.with_column(col("date").cast(pl.Date).alias("date-yyyy-mm-dd")).sort(["date-yyyy-mm-dd", "values"])
print(out)

