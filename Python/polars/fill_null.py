import polars as pl
import click


def fill_null(df):
    return (df.sort(['order_id', 'rel_time'])
              .fill_null(strategy="forward")
    )


@click.command()
@click.option('--input-path', help='输入文件路径')
@click.option('--output-path', help='输出文件路径')
def back_fill(input_path, output_path):
    dtypes = {
        'dt': pl.Utf8,
        'order_id': pl.Utf8,
        'device_id': pl.Utf8,
        'rel_time': pl.UInt32,
        'abs_time': pl.Utf8,
        'bcs_voltMeasure': pl.Float64,
        'bcs_currentMeasure': pl.Float64,
        'ccs_outVolt': pl.Float64,
        'ccs_outCurrent': pl.Float64
    }
    df = pl.read_excel(input_path, read_csv_options={"has_header": True, "dtypes": dtypes})#.filter(
    #     pl.col("bcs_volt_measure").is_not_null() &
    #     pl.col("bcs_current_measure").is_not_null()
    # )
    
    df.pipe(fill_null) \
      .write_excel(output_path)

if __name__ == '__main__':
    back_fill()
