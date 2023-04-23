import polars as pl
from polars.lazy import *

# A scan is a lazy read. This means nothing happens.
reddit = pl.scan_csv("data/reddit_accounts.csv")

reddit = (
    reddit.filter(col("comment_karma") > 0)  # only positive comment karma
    .filter(col("link_karma") > 0)  # only positive link karma
    .filter(col("name").str_contains(r"^a"))  # filter name that start with an "a"
)

reddit.show_graph(optimized=False)

print(reddit.fetch(n_rows=int(1e7)).head())
