# -*- coding: utf-8 -*-

import click
from kafka import KafkaProducer
from kafka.errors import KafkaError
import json 

class OrderKafkaProducer():
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

# 把 JSON 数据发到 Kafka, 用于测试。
@click.command()
@click.option('--input-path', default='test.txt', help='JSON file')
@click.option('--bootstrap-servers', default='localhost:9092', help='bootstrap servers')
@click.option('--topic', default='test', help='charge topic')
def charge_order(input_path, bootstrap_servers, topic):
    sender = OrderKafkaProducer(bootstrap_servers=bootstrap_servers, topic=topic)
    with open(input_path) as f:
        for line in f.readlines():
            json_data = json.loads(line.strip())
            sender.sendjsondata(json_data, str(json_data['deviceId']))
        
if __name__ == '__main__':
    charge_order()
