import pandas as pd

dict = {
    'a': [1.0, 2.0, 3.0],
    'b': [1.1, 2.1, 3.1],
    'c': ['AM', 'AM', 'PM']
}

df = pd.DataFrame(dict)
print(df.head())