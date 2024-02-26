# -*- encoding: utf-8 -*-

import click
import pandas as pd
from impala.dbapi import connect
from datetime import datetime, timedelta


@click.command()
@click.option('--station-id', help='场站编号')
@click.option('--station-name', help='场站名称')
@click.option('--start-day', help='开始日期, yyyyMMdd 格式')
@click.option('--end-day', help='结束日期, yyyyMMdd 格式')
@click.option('--output', help='输出路径')
def daily_charging_power_with_multi_sheets(station_id, station_name, start_day, end_day, output):
    conn = connect(host='localhost', port=10000, auth_mechanism='PLAIN', user="hadoop")
    cursor = conn.cursor()

    cols = ['hour_ratio', 'daily_power']
    output_excel = f"{output}/{station_id}-{station_name}.xlsx"

    date_list = []
    start_day = datetime.strptime(start_day, '%Y%m%d')
    end_day = datetime.strptime(end_day, '%Y%m%d')

    while start_day <= end_day:
        date_list.append(datetime.strftime(start_day, '%Y%m%d'))
        start_day += timedelta(days=1)

    with pd.ExcelWriter(output_excel) as writer:
        for dt in date_list:
            cursor.execute(
                f"select {','.join(cols)} from hive_table where dt='{dt}' and station_id='{station_id}'")
            data = cursor.fetchall()
            if data is not None:
                df = pd.DataFrame(data, columns=cols)
                if not df.empty:
                    df.to_excel(writer, sheet_name=f"{str(dt)}", index=False)
    cursor.close()
    conn.close()


if __name__ == '__main__':
    daily_charging_power_with_multi_sheets()
