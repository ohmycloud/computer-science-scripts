import pandas as pd
from pyspark.sql.types import *
from pyspark.sql.functions import pandas_udf
from pyspark.sql.functions import PandasUDFType

schema = StructType([
    StructField("key", StringType()),
    StructField("avg_min", DoubleType())
])

@pandas_udf(schema, functionType=PandasUDFType.GROUPED_MAP)
def g(df):
    result = pd.DataFrame(df.groupby(df.key).apply(
        lambda x: x.loc[:, ["value1", "value2"]].min(axis=1).mean()
    ))
    result.reset_index(inplace=True, drop=False)
    return result

if __name__ == '__main__':

    spark = SparkSession \
        .builder \
        .appName("Spark Structured Streaming Example") \
        .getOrCreate()



    df = spark.createDataFrame(
        [("a", 1, 0), ("a", -1, 42), ("b", 3, -1), ("b", 10, -2)],
        ("key", "value1", "value2")
    )

    df.groupby("key").apply(g).show()