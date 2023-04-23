from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import *
from pyspark.sql.functions import col, pandas_udf
from pyspark.sql.functions import PandasUDFType
import numpy as np

if __name__ == '__main__':
    spark = SparkSession \
        .builder \
        .appName("Spark Structured Streaming Example") \
        .getOrCreate()
    
    spark.sparkContext.setLogLevel('WARN')

    @pandas_udf(DoubleType(), functionType=PandasUDFType.GROUPED_AGG)
    def f(x, y):
        return np.minimum(x, y).mean()
    
    schema = StructType() \
        .add('key', StringType()) \
        .add('value1', IntegerType()) \
        .add('value2', IntegerType()) \
        .add('timestamp', TimestampType())

    path = "/home/ohmycloud/opt/scripts/PySpark/data/ss"
    df = spark.readStream \
        .format('csv') \
        .option('header', True) \
        .option("checkpointLocation", "/tmp/readstream") \
        .load(path, encoding='gbk', schema=schema)    
    
    res = df.groupBy("key") \
    .agg(f("value1", "value2") \
    .alias("avg_min"))

    query = res.writeStream \
      .format("console") \
      .outputMode("update") \
      .queryName("debuging") \
      .trigger(once=True) \
      .start()

    spark.streams.awaitAnyTermination()

    # error: Streaming aggregation doesn't support group aggregate pandas UDF;