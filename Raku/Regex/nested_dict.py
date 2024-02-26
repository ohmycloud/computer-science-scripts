from datetime import datetime, timedelta
from collections import defaultdict
import click


def nested_dict():
    """年份、月份和小时嵌套字典
    """
    return defaultdict(nested_dict)


@click.command()
@click.option('--start-time', help='开始时间')
@click.option('--end-time', help='结束时间')
def hour_in_month(start_time: str, end_time: str) -> dict:
    """get unique year, months and hours between start_time and end_time
    :param start_time: 开始时间
    :param end_time: 结束时间
    """
    hour_config = nested_dict()
    start_date = datetime.strptime(start_time, '%Y-%m-%d %H:%M:%S')
    end_date = datetime.strptime(end_time, '%Y-%m-%d %H:%M:%S')
    loop_date = start_date
    while loop_date <= end_date:
        year = loop_date.year
        month = loop_date.month
        hour = loop_date.hour
        hour_config[year][month][hour] = 1
        loop_date += timedelta(seconds=1)
  
    for year, v in hour_config.items():
        for month, vv in v.items():
            for hour, vvv in vv.items():
              print(year, month, hour)

if __name__ == '__main__':
    hour_in_month()
