import polars as pl

def df_from_database():
    connection_uri = "mysql://root:xxx@123@127.0.0.1:3306/test"
    query = "SELECT * FROM test"
    return pl.read_database(query=query, connection_uri=connection_uri)

def max_index(df: pl.DataFrame):
    return (df.with_columns([
        pl.col('index').max().over('message_type').alias('max_index')
    ]))

if __name__ == '__main__':
    df=df_from_database()
    df=df.pipe(max_index) \
         .filter(pl.col('index') == pl.col('max_index'))
    df.write_excel('index.xlsx')
