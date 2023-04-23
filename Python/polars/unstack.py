# -*- coding: utf-8 -*-

import polars as pl
from string import ascii_uppercase

df = pl.DataFrame({
    "col1": list(ascii_uppercase),
    "col2": pl.arange(0, 26, eager=True),
})
print(df)

df1 = df.unstack(step=26, how='horizontal', columns = 'col1')
print(df1)