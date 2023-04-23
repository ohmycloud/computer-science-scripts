import polars as pl
from dataclasses import dataclass

@dataclass
class Item:
    ham: int
    spam: int
    foo: int

df = pl.DataFrame({"ham": [2, 2, 3],
                   "spam": [11, 22, 33],
                   "foo": [3, 2, 1]})

def my_complicated_function(struct: dict) -> Item:
    item = Item(ham = struct['ham'], spam = struct['spam'], foo = struct['foo'])
    #return struct["ham"] + struct["spam"] + struct["foo"]
    return item

print(df)

df = df.select([
        pl.struct(["ham", "spam", "foo"]).apply(my_complicated_function)
])
print(df)
