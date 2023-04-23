import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, pandas_udf
from pyspark.sql.functions import PandasUDFType
from pyspark.sql.types import *

# Grouped map UDFs
# 这个函数适用于groupBy().apply() 实现“拆分应用组合”模式，它分为三个步骤
# 1.使用DataFrame.groupBy分割数据
# 2.对每个group使用函数，输入输出都是pandas.DataFrame，输入数据包含每个groupy的所有行和列
# 3.合并结果称为一个新的DataFrame
# 使用groupBy().apply()你必须做以下定义
# 1.定义每个group的计算的python函数
# 2.一个StructType对象或者string定义输出DataFrame的schema
### 在应用函数之前，组的所有数据都将加载到内存中。这可能导致内存不足异常,特别是不同group是倾斜的

schema = StructType([
  StructField("id", LongType(),True),
  StructField("v", FloatType(),True)
])

@pandas_udf(schema, PandasUDFType.GROUPED_MAP)
def subtract_mean(df):
    # df is a pandas.DataFrame
    v = df.v
    return df.assign(v=v - v.mean())

def _subtract_mean(df):
    # df is a pandas.DataFrame
    v = df.v
    return df.assign(v=v - v.mean())

if __name__ == '__main__':
    spark = SparkSession \
        .builder \
        .appName("SparkSQL Example") \
        .getOrCreate()
    
    df = spark.createDataFrame([
        (1, 1.0), (1, 2.0), (2, 3.0), (2, 5.0), (2, 10.0)],
        ("id", "v")
    )

    df.groupby("id") \
    .apply(subtract_mean) \
    .show()
    
    subtract_mean2 = pandas_udf(
        _subtract_mean,
        returnType="id long, v double",
        functionType=PandasUDFType.GROUPED_MAP
    )
    
    df.groupby("id") \
    .apply(subtract_mean2) \
    .show()


"""
+---+----+
| id|   v|
+---+----+
|  1|-0.5|
|  1| 0.5|
|  2|-3.0|
|  2|-1.0|
|  2| 4.0|
+---+----+


+---+----+
| id|   v|
+---+----+
|  1|-0.5|
|  1| 0.5|
|  2|-3.0|
|  2|-1.0|
|  2| 4.0|
+---+----+
"""