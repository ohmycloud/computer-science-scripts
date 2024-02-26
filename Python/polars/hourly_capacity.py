# -*- coding: utf-8 -*-

import click
import polars as pl


@click.command()
@click.option('--input-path', type=str, help='输入文件路径')
@click.option('--output-path', type=str, help='输出文件路径')
def pivot(input_path, output_path):
    df = pl.read_csv(source=input_path) \
        .pivot(
        values='hourly_capacity',
        index=['station_id', 'station_name', 'dt'],
        columns=['hour'],
        maintain_order=True,
        sort_columns=True
    )

    hours = [str(i) for i in range(0, 24)]
    columns = df.columns
    column_difference = set(hours) - set(columns)

    if len(list(column_difference)) > 0:
        df = df.with_columns([pl.lit(None).alias(i) for i in column_difference])

    df = df.groupby(['station_id', 'station_name', 'dt']) \
        .agg(
        [
            pl.sum("0").alias("0"),
            pl.sum("1").alias("1"),
            pl.sum("2").alias("2"),
            pl.sum("3").alias("3"),
            pl.sum("4").alias("4"),
            pl.sum("5").alias("5"),
            pl.sum("6").alias("6"),
            pl.sum("7").alias("7"),
            pl.sum("8").alias("8"),
            pl.sum("9").alias("9"),
            pl.sum("10").alias("10"),
            pl.sum("11").alias("11"),
            pl.sum("12").alias("12"),
            pl.sum("13").alias("13"),
            pl.sum("14").alias("14"),
            pl.sum("15").alias("15"),
            pl.sum("16").alias("16"),
            pl.sum("17").alias("17"),
            pl.sum("18").alias("18"),
            pl.sum("19").alias("19"),
            pl.sum("20").alias("20"),
            pl.sum("21").alias("21"),
            pl.sum("22").alias("22"),
            pl.sum("23").alias("23")
        ]
    )

    df.write_excel(output_path)


# https://stackoverflow.com/questions/70830241/rust-polars-how-to-show-all-columns
# export POLARS_FMT_MAX_COLS=45
# python hourly-charge-capacity-export.py --input-path=charge-capacity.csv --output-path=charge-capacity.xlsx
if __name__ == '__main__':
    pivot()
