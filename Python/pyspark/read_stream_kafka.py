from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import StructType, StringType

if __name__ == '__main__':

    spark = SparkSession \
        .builder \
        .appName("Spark Structured Streaming Example") \
        .getOrCreate()

    schema = StructType() \
        .add("a", StringType()) \
        .add("b", StringType()) \
        .add("c", StringType()) \
        .add("d", StringType()) \
        .add("e", StringType())

    df = spark.readStream \
        .format('kafka') \
        .option("kafka.bootstrap.servers", "localhost:9092") \
        .option("subscribe", "test") \
        .option("checkpointLocation", "/apps/checkpoint/readstream") \
        .load()

    res = df.selectExpr("CAST(value AS STRING)").select(from_json("value", schema).alias("d")).select("d.*")

    query = res.writeStream \
      .format("console") \
      .outputMode("append") \
      .queryName("debuging") \
      .start()

    spark.streams.awaitAnyTermination()
    