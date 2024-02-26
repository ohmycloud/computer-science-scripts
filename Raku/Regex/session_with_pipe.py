import polars as pl
from pathlib import Path

def set_types(dataf):
    return (dataf
            .with_columns([
                pl.col("timestamp").str.strptime(pl.Datetime, format="%m/%d/%y %H:%M:%S"),
                pl.col("guild") != -1,
            ])
    )

def sessionize(dataf: pl.DataFrame, threshold=20 * 60 * 1_000):
    return (dataf
            .sort(["char", "timestamp"])
            .with_columns([
                (pl.col("timestamp").diff().cast(pl.Int64) > threshold).fill_null(True).alias("ts_diff"),
                (pl.col("char").diff() != 0).fill_null(True).alias("char_diff"),
            ])
            .with_columns([
                (pl.col("ts_diff") | pl.col("char_diff")).alias("new_session_mark")
            ])
            .with_columns([
                pl.col("new_session_mark").cumsum().alias("session")
            ])
            .drop(['char_diff', 'ts_diff', 'new_session_mark'])
    )

def add_features(dataf: pl.DataFrame) -> pl.DataFrame:
    return (dataf
            .with_columns([
                # calculate the number of rows for each session
                pl.col("char").count().over("session").alias("session_length"),
                # calculates the number of unique session ids per character
                pl.col("session").n_unique().over("char").alias("n_sessions")
            ])
    )

def remove_bots(dataf: pl.DataFrame, threshold=24) -> pl.DataFrame:
    n_rows = threshold * 6
    return (dataf
            .filter(pl.col("session_length").max().over("char") < n_rows)
    )

if __name__ == '__main__':
    output: Path = Path('/Users/ohmycloud/Downloads/archive') / "output.csv"
    df = pl.read_csv("wowah_data.csv")
    df.columns = [c.replace(" ", "") for c in df.columns]

    df.pipe(set_types) \
      .pipe(sessionize, threshold=20*60*1000) \
      .pipe(add_features) \
      .pipe(remove_bots, threshold=24) \
      .write_csv(output, separator=",")
