# -*- encoding: utf-8 -*-

from impala.dbapi import connect
import click


@click.command()
@click.option('--start-day', help='订单数据开始区间日期, yyyyMMdd 格式')
@click.option('--end-day', help='订单数据结束区间日期, yyyyMMdd 格式')
@click.option('--city-name', help='城市名, 例如深圳市')
@click.option('--task-name', type=click.Choice(['monthlyCapacity', 'dailyPower', 'monthlyPower'], case_sensitive=True), help='任务名称')
def station_of_city(start_day, end_day, city_name, task_name):
    conn = connect(host='localhost', port=10000, auth_mechanism='PLAIN', user="hadoop")
    cursor = conn.cursor()

    sql_query_string = f"select a, b, c, d from table where dt >= '{start_day}' and dt <= '{end_day}' and city = '{city_name}' order by station_id, start_month"
    cursor.execute(sql_query_string)
    results = cursor.fetchall()
    for row in results:
        station_id = row[0]
        station_name = row[1]
        start_month = row[2]
        city = row[3]
        print(f"./spark-submit --stationId={station_id} --stationName={station_name} --startMonth={start_month} --cityName={city} --workDay=2 --taskName={task_name}")

    cursor.close()
    conn.close()


# python generate-spark-submit.py --start-day=20220101 --end-day=20221031 --city-name=深圳市 --task-name=monthlyCapacity
if __name__ == '__main__':
    station_of_city()
