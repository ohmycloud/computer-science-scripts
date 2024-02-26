import polars as pl
import click


def fill_null(df):
    return df.sort(["order_id", "rel_time"]).fill_null(strategy="forward")


@click.command()
@click.option("--input-path", help="输入文件路径")
@click.option("--output-path", help="输出文件路径")
def back_fill(input_path, output_path):
    dtypes = {
        "connector_name": pl.Categorical,
        "model_id": pl.Categorical,
        "dt": pl.Categorical,
        "order_id": pl.Categorical,
        "device_id": pl.Categorical,
        "rel_time": pl.UInt32,
        "bcs_volt_measure": pl.Float64,
        "bcs_current_measure": pl.Float64,
        "ccs_out_volt": pl.Float64,
        "ccs_out_current": pl.Float64,
    }
    df = pl.scan_csv(input_path, dtypes=dtypes)  # .filter(
    #     pl.col("bcs_volt_measure").is_not_null() &
    #     pl.col("bcs_current_measure").is_not_null()
    # )

    df.pipe(fill_null).collect(streaming=True).write_csv(output_path)


if __name__ == "__main__":
    back_fill()
