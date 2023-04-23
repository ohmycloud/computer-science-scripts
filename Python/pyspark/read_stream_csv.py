from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import StructType, StringType

if __name__ == '__main__':

    spark = SparkSession \
        .builder \
        .appName("Spark Structured Streaming Example") \
        .getOrCreate()

    schema = StructType() \
        .add('created', StringType()) \
        .add('vin', StringType()) \
        .add('soc_display', StringType()) \
        .add('voltage', StringType()) \
        .add('total_current', StringType()) \
        .add('speed', StringType()) \
        .add('mileage', StringType()) \
        .add('highest_voltage', StringType()) \
        .add('lowest_voltage', StringType()) \
        .add('highest_temp', StringType()) \
        .add('lowest_temp', StringType()) \
        .add('battery_temps', StringType()) \
        .add('battery_voltages', StringType()) \
        .add('category', StringType()) \
        .add('order', StringType())

    path = "./data/test"
    df = spark.readStream \
        .format('csv') \
        .option('header', False) \
        .option("checkpointLocation", "/tmp/readstream") \
        .load(path, encoding='gbk', schema=schema)

    query = df.writeStream \
      .format("console") \
      .outputMode("append") \
      .queryName("debuging") \
      .trigger(once=True) \
      .start()

    spark.streams.awaitAnyTermination()
    