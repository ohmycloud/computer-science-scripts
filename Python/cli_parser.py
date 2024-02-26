# -*- encoding: utf-8 -*-

import argparse
from datetime import datetime, timedelta

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="解析命令行参数")
    parser.add_argument('--start-day', type=str, default=None, required=True, help='开始日期')
    parser.add_argument('--end-day', type=str, default=None, required=True, help='结束日期')
    args = parser.parse_args()

    start_day = args.start_day
    end_day = args.end_day
    date_list = []
    
    start_day = datetime.strptime(start_day, '%Y%m%d')
    end_day = datetime.strptime(end_day, '%Y%m%d')

    while start_day <= end_day:
        date_list.append(datetime.strftime(start_day, '%Y%m%d'))
        start_day += timedelta(days=1)

    for day in date_list:
        print(day)
