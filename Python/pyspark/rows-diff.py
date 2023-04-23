# -*- coding:utf-8 -*-

from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql import functions as F
from pyspark.sql.window import Window

sc = SparkContext(appName="PrevRowDiffApp")
sqlc = SQLContext(sc)

rdd = sc.parallelize([(1, 65), (2, 66), (3, 65), (4, 68), (5, 71)])

df = sqlc.createDataFrame(rdd, ["id", "value"])

my_window = Window.partitionBy().orderBy("id")

df = df.withColumn("prev_value", F.lag(df.value).over(my_window))
df = df.withColumn("diff", F.when(F.isnull(df.value - df.prev_value), 0)
                              .otherwise(df.value - df.prev_value))

df.show()