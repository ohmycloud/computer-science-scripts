import numpy as np
import pandas as pd
from pyspark.sql import SparkSession


if __name__ == '__main__':
    spark = SparkSession \
        .builder \
        .appName("Spark Structured Streaming Example") \
        .getOrCreate()
    
    spark.sparkContext.setLogLevel('WARN')

    # Enable Arrow-based columnar data transfers
    spark.conf.set("spark.sql.execution.arrow.pyspark.enabled", "true")
    
    # Generate a Pandas DataFrame
    pdf = pd.DataFrame(np.random.rand(100, 3))
    #pdf.head()
    
    # Create a Spark DataFrame from a Pandas DataFrame using Arrow
    df = spark.createDataFrame(pdf)
    #df.show()
    
    # Convert the Spark DataFrame back to a Pandas DataFrame using Arrow
    result_pdf = df.select("*").toPandas()
    result_pdf.head()

    spark.stop


