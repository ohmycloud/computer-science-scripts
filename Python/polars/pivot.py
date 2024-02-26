import polars as pl
import click


@click.command()
@click.option('--input-path', help='文件路径')
@click.option('--sheet-name', default = 'Sheet1', help='worksheet名称')
@click.option('--output-path', help='输出文件名')
def main(input_path, sheet_name, output_path):
    dtypes = {
        'day': pl.Utf8,
        'hour': pl.Utf8,
        'soc': pl.Utf8
    }
    df = pl.read_excel(input_path, read_csv_options={"has_header": True, "dtypes": dtypes}) \
           .select([
            pl.col('day'),
            pl.col('hour'),
            pl.col('soc')
           ]) \
           .pivot(
            values='soc',
            index=['day'],
            columns='hour'
           )

    df.write_excel(output_path)


if __name__ == '__main__':
    main()
