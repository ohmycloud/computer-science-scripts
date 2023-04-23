import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, pandas_udf
from pyspark.sql.functions import PandasUDFType
from pyspark.sql.types import *

schema = StructType([
    StructField("key", StringType()),
    StructField("avg_value1", DoubleType()),
    StructField("avg_value2", DoubleType()),
    StructField("sum_avg", DoubleType()),
    StructField("sub_avg", DoubleType())
])

@pandas_udf(schema, functionType=PandasUDFType.GROUPED_MAP)
def g(df):
    gr = df['key'].iloc[0]
    x = df.value1.mean()
    y = df.value2.mean()
    w = df.value1.mean() + df.value2.mean()
    z = df.value1.mean() - df.value2.mean()
    return pd.DataFrame([[gr]+[x]+[y]+[w]+[z]])

if __name__ == '__main__':
    spark = SparkSession \
        .builder \
        .appName("Spark Structured Streaming Example") \
        .getOrCreate()
    
    spark.sparkContext.setLogLevel('WARN')

    schema = StructType() \
        .add('key', StringType()) \
        .add('value1', IntegerType()) \
        .add('value2', IntegerType())

    path = "/home/ohmycloud/opt/scripts/PySpark/data/ss"
    df = spark.readStream \
        .format('csv') \
        .option('header', True) \
        .option("checkpointLocation", "/tmp/readstream") \
        .load(path, encoding='gbk', schema=schema)    
    

    df2 = df.groupby("key").apply(g)

    query = df2.writeStream \
      .format("console") \
      .outputMode("append") \
      .queryName("debuging") \
      .trigger(once=True) \
      .start()

    spark.streams.awaitAnyTermination()

"""
+---+----------+----------+-------+-------+
|key|avg_value1|avg_value2|sum_avg|sub_avg|
+---+----------+----------+-------+-------+
|  b|       6.5|      -1.5|    5.0|    8.0|
|  a|       0.0|      21.0|   21.0|  -21.0|
+---+----------+----------+-------+-------+
"""