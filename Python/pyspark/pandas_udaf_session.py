import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import pandas_udf
from pyspark.sql.functions import PandasUDFType

spark = SparkSession \
        .builder \
        .appName("Pandas UDFs Benchmark") \
        .config("spark.sql.shuffle.partitions", 48) \
        .getOrCreate()

spark.sparkContext.setLogLevel("WARN")

df = spark.createDataFrame(
    [("a", 1, 0), 
     ("a", 2, 1), 
     ("a", 3, 2), 
     ("a", 4, 3),
     ("a", 5, 4), 
     ("a", 25, 5), 
     ("a", 26, 6),
     ("a", 27, 7),
     ("a", 75, 8),
     ("a", 80, 9),
     ("b", 3, -1), 
     ("b", 10, -2)],
    ("key", "value1", "value2")
)

columns = df.columns
label = ['start', 'end']

schema = StructType() \
    .add('key', StringType(), True) \
    .add('value1', IntegerType(), True) \
    .add('value2', IntegerType(), True) \
    .add('start', IntegerType(), True) \
    .add('end', IntegerType(), True)

@pandas_udf(schema, functionType=PandasUDFType.GROUPED_MAP)
def g(df):
    values1 = df['value1'].values
    start = values1[0]
    end   = values1[0]

    start_time = []
    end_time = []

    for x in values1:
        if (x - end > 10):
            start = x
            end   = x
        else:
            end   = x
        start_time.append(start)
        end_time.append(end)    

    return df.assign(start = start_time, end = end_time)

df.groupby("key").apply(g).show()

"""
+---+------+------+-----+---+
|key|value1|value2|start|end|
+---+------+------+-----+---+
|  a|     1|     0|    1|  1|
|  a|     2|     1|    1|  2|
|  a|     3|     2|    1|  3|
|  a|     4|     3|    1|  4|
|  a|     5|     4|    1|  5|
|  a|    25|     5|   25| 25|
|  a|    26|     6|   25| 26|
|  a|    27|     7|   25| 27|
|  a|    75|     8|   75| 75|
|  a|    80|     9|   75| 80|
|  b|     3|    -1|    3|  3|
|  b|    10|    -2|    3| 10|
+---+------+------+-----+---+
"""