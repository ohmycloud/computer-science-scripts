# -*- encoding: utf-8 -*-

import polars as pl
import click
from pyarrow.dataset import dataset
from impala.dbapi import connect

def target_capacity(dt, device_id, order_id):
    conn = connect(host='host1', port=10000, auth_mechanism='PLAIN', user="hadoop")
    cursor = conn.cursor()

    sql_query_string = f"select order_id, rel_time, ccs_out_volt, ccs_out_current from dwd.dwd_wcd_pile_data_detail_dupli_di where dt = '{dt}' and device_id = '{device_id}' and order_id = '{order_id}' order by rel_time"
    cursor.execute(sql_query_string)
    results = cursor.fetchall()
    data = []
    for row in results:
        order_id = row[0]
        rel_time = row[1]
        ccs_out_volt = row[2]
        ccs_out_current = row[3]

        if order_id != None:
            data.append({
                'orderId': order_id,
                'relativeTime': rel_time,
                'ccsOutVolt': ccs_out_volt,
                'ccsOutCurrent': ccs_out_current
            })

    cursor.close()
    conn.close()

    return pl.from_dicts(data).select(
        [
            pl.col('orderId').cast(pl.Utf8),
            pl.col('relativeTime').cast(pl.Utf8),
            pl.col('ccsOutVolt').cast(pl.Float64),
            pl.col('ccsOutCurrent').cast(pl.Float64)
        ]
    )


def ccs_data(df: pl.DataFrame):
    return (df.filter(pl.col('ccsOutVolt') > 0) \
                   .select([
                      pl.col('orderId'),
                      pl.col('relativeTime'),
                      pl.col('ccsOutVolt'),
                      pl.col('ccsOutCurrent')
                   ]))

@click.command()
@click.option('--dt', help='日期分区')
@click.option('--old-device-id', help='旧设备编号')
@click.option('--new-order-id', help='新订单编号')
@click.option('--old-order-id', help='旧订单编号')
@click.option('--input-path', help='输入文件路径')
@click.option('--table-cols', type=int, default=10, help='表格的列数')
def stat(dt, old_device_id, new_order_id, old_order_id, input_path, table_cols):
    with pl.Config() as cfg:
        cfg.set_tbl_cols(table_cols)
        pds = dataset(source = input_path, filesystem='hdfs://host1:8020', format='parquet')
        df = pl.scan_pyarrow_dataset(pds).filter(pl.col('orderId') == new_order_id)
        ccs_df = df.pipe(ccs_data)

        print('old deviceId...')

        ds_capacity = target_capacity(dt, old_device_id, old_order_id)
        target_ccs_df = ds_capacity.filter(pl.col('ccsOutVolt') > 0)

        ccs_df.write_excel('old_ccs.xlsx')
        target_ccs_df.write_excel('new_ccs.xlsx')
    


if __name__ == '__main__':
    stat()
