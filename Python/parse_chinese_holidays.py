# -*- encoding: utf-8 -*-

import click
import json
import re
import pandas as pd


@click.command()
@click.option('--file-name', help='JSON文件名')
def chinese_holiday(file_name):
    json_list = []
    week_dict = dict(zip(['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'], [0, 1, 2, 3, 4, 5, 6]))
    with open(file_name, 'rb') as f:
        data = json.load(f)
        for day in data:
            dict_of_day = data[day]
            updated_dict = {
                'year': int(re.findall(r'\d+', dict_of_day['year'])[0]),
                'month': int(re.findall(r'\d+', dict_of_day['month'])[1]),
                'date': day,
                'yearweek': int(re.findall(r'\d+', dict_of_day['yearweek'])[1]),
                'yearday': int(re.findall(r'\d+', dict_of_day['yearday'])[1]),
                'lunar_yearday': int(re.findall(r'\d+', dict_of_day['lunar_yearday'])[1]),
                'week': week_dict[dict_of_day['week']]
            }
            dict_of_day.update(updated_dict)
            json_list.append(dict_of_day)

    df = pd.DataFrame.from_records(json_list)
    df.to_parquet('chinese_holiday', engine='pyarrow', compression='snappy')


# 1) 去 https://github.com/lecepin/chinese-holidays-query 下载 JSON 文件
# 2）python parse-chinese-holidays.py --file=2024.json
# 3) sudo -su hdfs hdfs dfs -put /tmp/2024.snappy.parquet hdfs://ns1:8020/data/3rdparty/chinese_holidays/2024.snappy.parquet
# 4) 执行 beeline -u jdbc:hive2://datahouse-master2:10000 -n hadoop
# 5）use dim; load data inpath "hdfs://ns1:8020/data/3rdparty/chinese_holidays/2024.snappy.parquet" into table dim_mcd_chinese_holidays_ci;
# 解析中国法定节假日 JSON 文件, 并转换为 parquet 文件
if __name__ == '__main__':
    chinese_holiday()
