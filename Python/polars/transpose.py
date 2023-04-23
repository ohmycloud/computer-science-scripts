# -*- coding: utf-8 -*-

import polars as pl

df = pl.DataFrame({
    "a": [1, 2, 3],
    "b": [4, 5, 6]
})

print(df)

df1 = df.transpose(include_header=True)
print(df1)

# replace the auto-genrated names with a list
df2 = df.transpose(include_header=False, column_names=['a', 'b', 'c'])
print(df2)

# include the header as a separate column
df3 = df.transpose(include_header=True, header_name="foo", column_names=['a', 'b', 'c'])
print(df3)


def name_generator():
    base_name = '__my_column__'
    count = 0
    while True:
        yield f"{base_name}{count}"
        count += 1

# Replace the auto-generated column with column names from a generator function
df4 = df.transpose(include_header=False, column_names=name_generator())
print(df4)