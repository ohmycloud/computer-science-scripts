import polars as pl
import click


def ccs_data(df: pl.DataFrame):
    return (df.filter(pl.col('ccsOutVolt') > 0))


def ccs_adadpter(df: pl.DataFrame):
    return (df.with_columns([(pl.col("ccsOutVolt") * pl.col('ccsOutCurrent').abs()).alias('power')]))


def ccs_capacity_stat(df: pl.DataFrame):
    return (df.groupby('orderId') \
               .agg([
                (pl.col("ccsOutVolt") * pl.col("ccsOutCurrent")).sum().alias("ccs_total_power"),
                ((pl.col("ccsOutVolt") * pl.col("ccsOutCurrent")).sum() / 3600000.0).alias("ccs_capacity")
               ]))


def max_by_power(df: pl.DataFrame):
    return (df.with_columns([
        pl.col("power").max().over("relativeTime").alias("max_power")
    ]))

def remove_rows(df: pl.DataFrame):
    return (df.filter(pl.col('power') == pl.col('max_power')))


@click.command()
@click.option('--input-path', help='输入文件路径')
def capacity(input_path):
    dtypes = {
        'dt': pl.Utf8,
        'order_id': pl.Utf8,
        'device_id': pl.Utf8,
        'rel_time': pl.UInt32,
        'abs_time': pl.Utf8,
        'ccs_outVolt': pl.Float64,
        'ccs_outCurrent': pl.Float64
    }
    df = pl.read_excel(input_path, read_csv_options={"has_header": True, "dtypes": dtypes}) \
           .select([
              pl.col('order_id').alias('orderId'),
              pl.col('rel_time').alias('relativeTime'),
              pl.col('ccs_outVolt').alias('ccsOutVolt'),
              pl.col('ccs_outCurrent').alias('ccsOutCurrent'),
           ])
    

    ccs_df = df.pipe(ccs_data)
    ccs_capacity = ccs_df.pipe(ccs_capacity_stat)
    ccs_capacity.write_excel('output.xlsx')


if __name__ == '__main__':
    capacity()
