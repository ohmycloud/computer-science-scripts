# -*- coding: utf-8 -*-

import pandas as pd
from sqlalchemy import create_engine

host = '127.0.0.1'
port = 3306
db = 'test'
user = 'test'
password = 'test'


import pymysql
pymysql.install_as_MySQLdb()

engine = create_engine(str(r"mysql://%s:" + '%s' + "@%s/%s") % (user, password, host, db))

df = pd.read_csv('input.csv', sep=',', quotechar='\'', encoding='GB2312')
df.to_sql('input_table',con=engine,index=False,if_exists='append')
