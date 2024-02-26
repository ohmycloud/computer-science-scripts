# -*- encoding: utf-8 -*-

import polars as pl
import click


@click.command()
@click.option('--input-path', help='输入文件路径')
@click.option('--sheet-name', help='Sheet 名')
def stat(input_path, sheet_name):
    dtypes = {
        '订单编号': pl.Categorical,
        '充电开始时间': pl.Categorical,
        '充电结束时间': pl.Categorical,
        '充电量': pl.Float64,
        '模块编号': pl.Categorical,
    }
    df = pl.read_excel(
        input_path,
        sheet_name=sheet_name,
        xlsx2csv_options={"skip_empty_lines": True},
        read_csv_options={"has_header": True, "dtypes": dtypes}
    )

    count = 0
    for i in df.partition_by(by='模块编号', include_key=True): 
        print(i)
        # i.write_excel(f'{count}.xlsx')
        count = count + 1

if __name__ == '__main__':
    stat()
