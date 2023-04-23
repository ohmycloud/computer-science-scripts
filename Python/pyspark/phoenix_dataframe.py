# -*- coding:utf-8 -*-
from pyspark import SparkContext, SparkConf
from pyspark.sql import SQLContext

# Example - https://github.com/zaratsian/SparkPhoenix/blob/master/pysparkPhoenixLoad.py
# spark-submit --jars ~/opt/apache-phoenix-4.14.0-HBase-1.2-bin/phoenix-4.14.0-HBase-1.2-client.jar  phoenix_dataframe.py
conf = SparkConf().setAppName("pysparkPhoenixLoad").setMaster("local")
sc   = SparkContext(conf=conf)
sqlContext = SQLContext(sc)

df = sqlContext.read \
  .format("jdbc") \
  .option("dbtable", "US_POPULATION") \
  .option("driver", "org.apache.phoenix.jdbc.PhoenixDriver") \
  .option("url", "jdbc:phoenix:localhost:/hbase") \
  .load()

df.show()

df2 = sqlContext.read \
  .format("jdbc") \
  .option("dbtable", "MILEAGE_ANXIETY") \
  .option("driver", "org.apache.phoenix.jdbc.PhoenixDriver") \
  .option("url", "jdbc:phoenix:localhost") \
  .load()

df2.show()
