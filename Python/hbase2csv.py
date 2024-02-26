# -*- coding: utf-8 -*-

import happybase
import click
import pandas as pd

@click.command()
@click.option('--table-name', help='hbase table name')
@click.option('--row-prefix', help='hbase row prefix')
@click.option('--hostname', default='host1')
@click.option('--output-path', default='output.csv')
def export(table_name, row_prefix, hostname, output_path):
    connection = happybase.Connection(hostname, protocol='compact', transport='framed')
    table = connection.table(table_name)
    tbs = table.scan(row_prefix=row_prefix.encode(), include_timestamp=False)

    res = []

    for key, data in tbs:
        dict = {}
        (device_id, order_dt, _) = key.decode().split('_')
        dict['orderId'] = device_id + order_dt
        dict['deviceId'] = device_id
        for k, v in data.items():
            d_key = k.decode()[2:] if ('d:' in k.decode()) else k.decode()
            d_value = v.decode()
            
            dict[d_key] = d_value

        res.append(dict)

    df = pd.DataFrame(res)
    df.to_csv(output_path, index=False)      

if __name__ == '__main__':
    export()
