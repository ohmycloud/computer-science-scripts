from pyspark.sql.functions import *
from pyspark.sql import SparkSession

# https://stackoverflow.com/questions/54604464/apache-avro-as-a-built-in-data-source-in-apache-spark-2-4
#| spark-submit --packages org.apache.spark:spark-avro_2.11:2.4.6 avro.py
if __name__ == '__main__':
    spark = SparkSession \
        .builder \
        .appName("avro app") \
        .getOrCreate()
    spark.sparkContext.setLogLevel('WARN')
    #spark.conf.set("spark.sql.execution.arrow.enabled", True)

    df = spark.read.format("avro").load("users.avro")
    df.show(5, False)
    df.select("name", "favorite_color").write.format("avro").save("namesAndFavColors.avro")
    spark.stop