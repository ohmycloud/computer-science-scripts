import pandas as pd
import numpy as np

def get ( series, idx ):
    value_idx = series [ 'index'].index ( idx )
    return series [ 'data'][ value_idx ]

songs1 = {
    'index': [0, 1, 2, 3],
    'data': [145, 142, 38, 13],
    'name': 'songs'
}

print(get(songs1, 1))    

songs1_series = pd.Series(songs1)
print(songs1_series)
print('xxxxxxxxxxxxxxxxxx')

songs = {
    'index': ['Paul', 'John', 'George', 'Ringo'],
    'data': [145, 142, 38, 13],
    'name': 'counts'
}

songs2=pd.Series(songs)
print(songs2)
print(get(songs, 'Ringo'))
print('xxxxxxxxxxxxxxxxxxxxxxxxxxxx')

ser2=pd.Series([145, 142, 38, 13], name='counts')
print(ser2.index)


songs3 = pd.Series(data=[145, 142, 38, 13], name='counts', index=['Paul', 'John', 'George', 'Ringo'])
print(songs3)
print(songs3.index)

class Foo:
    pass

ringo = pd.Series(
    ['Richard', 'Starkey', 13, Foo()], name='ringo'
)
print(ringo)

nan_series = pd.Series([2, np.nan], index=['Ono', 'Clapton'])
print(nan_series)

print(nan_series.count())
print(nan_series.size)

nan_series2 = pd.Series([2, None], index=['Ono', 'Clapton'], dtype='Int64')
print(nan_series2)

bool3 = songs3 > songs3.median()
print(bool3)

print(songs3[songs3 > songs3.median()])