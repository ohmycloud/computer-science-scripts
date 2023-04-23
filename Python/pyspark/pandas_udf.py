import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, pandas_udf
from pyspark.sql.functions import PandasUDFType
from pyspark.sql.types import *

def multiply_func(a, b):
    return a * b

@pandas_udf(returnType=FloatType(), functionType=PandasUDFType.SCALAR)
def plus(a,b):
  return a + b

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
    
    df = spark.createDataFrame(
        [(1,1.0, 1.0, 1), (1,1.2, 2.0, 1), (1,5.6, 3.0, 2), (1,24.4, 5.0, 2), (1,22.3, 10.0, 2)],
        ('id',"X", "Y","Z"))
    
    # pandans udf 使用说明
    # Scalar UDFs
    # 使用 PandasUDFType.SCALAR,当使用 select 和 withColumn 是使用该函数
    # 输入 pandas.Series 输出 pandas.Series，输入和输出长度相同
    # 在函数内部，spark 通过将列拆分来批量执行 pandas udf，将每个批的函数作为数据的子集调用，然后合并

    multiply = pandas_udf(
        multiply_func,
        returnType=FloatType(),
        functionType=PandasUDFType.SCALAR
    )

    df = (df
           .withColumn('M', multiply(df.X, df.Y))
           .withColumn('N', plus(df.X, df.Y))
          )
    df.show()

    df3 = spark.createDataFrame([("a", 1, 0), ("a", -1, 42), ("b", 3, -1), ("b", 10, -2)], ("key", "value1", "value2"))

    df3.groupby("key").apply(g).show()



"""
+---+----+----+---+-----+----+
| id|   X|   Y|  Z|    M|   N|
+---+----+----+---+-----+----+
|  1| 1.0| 1.0|  1|  1.0| 2.0|
|  1| 1.2| 2.0|  1|  2.4| 3.2|
|  1| 5.6| 3.0|  2| 16.8| 8.6|
|  1|24.4| 5.0|  2|122.0|29.4|
|  1|22.3|10.0|  2|223.0|32.3|
+---+----+----+---+-----+----+


+---+----------+----------+-------+-------+
|key|avg_value1|avg_value2|sum_avg|sub_avg|
+---+----------+----------+-------+-------+
|  b|       6.5|      -1.5|    5.0|    8.0|
|  a|       0.0|      21.0|   21.0|  -21.0|
+---+----------+----------+-------+-------+
"""