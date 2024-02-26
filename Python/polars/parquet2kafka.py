# -*- encoding: utf-8 -*-

import json
import time
import pandas as pd
import argparse
import glob
from kafka import KafkaProducer
from kafka.errors import KafkaError


class Kafka2ParquetProducer():
    def __init__(self, bootstrap_servers, topic):
        self.topic = topic
        self.producer = KafkaProducer(bootstrap_servers = bootstrap_servers)

    def sendjsondata(self, params,key):
        try:
            parmas_message = json.dumps(params,ensure_ascii=False)
            producer = self.producer
            v = parmas_message.encode('utf-8')
            k = key.encode('utf-8')
            producer.send(self.topic, key=k, value= v)
            producer.flush()
        except KafkaError as e:
            print (e)

def stack_parquet2_kafka(stack_file_path: str, bootstrap_servers: str, topic: str, interval: float):
    sender = Kafka2ParquetProducer(bootstrap_servers=bootstrap_servers, topic=topic)
    parquet_files = glob.glob(stack_file_path)

    for i in parquet_files:
        print("parquet file path = {parquet_file}".format(parquet_file=i))
    
    df = pd.concat([pd.read_parquet(p) for p in parquet_files])
    df['ts'] = pd.to_datetime(df['datetime']).astype('int64')//1000000000
    df = df.sort_values(by='ts', ascending=True)
    df = df.drop('ts', axis=1)

    for line in df.to_dict('record'):   
        print(line)
        sender.sendjsondata(line, str(line['tankNo']))
        time.sleep(interval)

def bank_parquet2_kafka(bank_file_path: str, bootstrap_servers: str, topic: str, interval: float):
    sender = Kafka2ParquetProducer(bootstrap_servers=bootstrap_servers, topic=topic)
    parquet_files = glob.glob(bank_file_path)

    for i in parquet_files:
        print("parquet file path = {parquet_file}".format(parquet_file=i))
    
    df = pd.concat([pd.read_parquet(p) for p in parquet_files])
    df['ts'] = pd.to_datetime(df['datetime']).astype('int64')//1000000000
    df = df.sort_values(by='ts', ascending=True)
    df = df.drop('ts', axis=1)

    for line in df.to_dict("record"):            
        print(line)
        sender.sendjsondata(line, str(line['tankNo']))
        time.sleep(interval)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="解析命令行参数")
    parser.add_argument('--station-no', type=str, default='1', required=True, help='场站编号')
    parser.add_argument('--tank-no', type=str, default=None, required=True, help='电池舱编号')
    parser.add_argument('--stack-no', type=str, default=None, required=True, help='汇流柜/电池堆编号')
    parser.add_argument('--group-no', type=str, default=None, required=False, help='电池簇编号')
    parser.add_argument('--day-no', type=str, default=None, required=True, help='日期')
    parser.add_argument('--stack-input-prefix', type=str, default=None, required=False, help='电池堆数据路径前缀')
    parser.add_argument('--bank-input-prefix', type=str, default=None, required=False, help='电池簇数据路径前缀')
    parser.add_argument('--stack-topic', type=str, default='stack_of_energy_storage', required=False, help='电池堆 topic')
    parser.add_argument('--bank-topic', type=str, default='bank_of_energy_storage', required=False, help='电池簇 topic')
    parser.add_argument('--interval', type=float, default=0.2, required=False, help='Kafka 发送消息的时间间隔')
    parser.add_argument('--flag', type=str, default='stack', required=False, help='默认电池堆, 否则电池簇')
    parser.add_argument('--bootstrap-servers', type=str, default='localhost:9092', required=False, help='bootstrap servers')
    args = parser.parse_args()

    # 电池堆 parquet 文件的路径
    stack_file_path = '{stack_input_prefix}\\station={station_no}\\tank={tank_no}\\stack={stack_no}\\day={day_no}\\*.parquet'.format(
        stack_input_prefix=args.stack_input_prefix,
        station_no=args.station_no,
        tank_no=args.tank_no,
        stack_no=args.stack_no,
        day_no=args.day_no)

    # 电池簇 parquet 文件的路径
    bank_file_path = '{bank_input_prefix}\\station={station_no}\\tank={tank_no}\\stack={stack_no}\\day={day_no}\\*.parquet'.format(
        bank_input_prefix=args.bank_input_prefix,
        station_no=args.station_no,
        tank_no=args.tank_no,
        stack_no=args.stack_no,
        day_no=args.day_no        
    )

    if (args.flag == 'stack'):
        stack_parquet2_kafka(stack_file_path, args.bootstrap_servers, args.stack_topic, args.interval)
    else:
        bank_parquet2_kafka(bank_file_path, args.bootstrap_servers, args.bank_topic, args.interval)
