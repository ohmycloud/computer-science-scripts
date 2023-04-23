from pyspark.sql import SparkSession, SQLContext
from pyspark.sql.functions import pandas_udf, PandasUDFType, col

spark = SparkSession.builder.appName('ReproduceBug') .getOrCreate()

df = spark.createDataFrame(
    [(1, "a"), (1, "a"), (1, "b")],
    ("id", "value"))
df.show()
# Spark DataFrame
# +---+-----+
# | id|value|
# +---+-----+
# |  1|    a|
# |  1|    a|
# |  1|    b|
# +---+-----+

# Potential Bug # 
@pandas_udf('double', PandasUDFType.SCALAR)
def compute_frequencies(value_col):
    total      = value_col.count()
    per_groups = value_col.groupby(value_col).transform('count')
    score      = per_groups / total
    return score

df.groupBy("id")\
  .apply(compute_frequencies)\
  .show()

spark.stop()