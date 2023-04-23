# -*- coding: utf-8 -*-

from pyflink.table import EnvironmentSettings, TableEnvironment
from pyflink.datastream.connectors import FileSink, OutputFileConfig
from pyflink.common.serialization import Encoder

import os
import sys
import shutil

if __name__ == '__main__':
    env_settings = EnvironmentSettings \
        .new_instance() \
        .in_batch_mode() \
        .build()

    table_env = TableEnvironment.create(environment_settings=env_settings)
    table_env \
        .get_config() \
        .get_configuration() \
        .set_string("parallelism.default", "1")

    # connector for ingesting the data
    source_ddl = """
                    CREATE TABLE MyStockTable (
                            InvoiceNo BIGINT,
                            StockCode BIGINT,
                            Description STRING,
                            Quantity INT,
                            InvoiceDate TIMESTAMP(0),
                            UnitPrice FLOAT,
                            CustomerID FLOAT,
                            Country STRING
                            ) WITH (
                              'connector' = 'filesystem',          
                              'path' = 'file:///opt/input-data/', 
                              'format' = 'csv',
                              'csv.ignore-parse-errors' = 'true'
                            )"""

    # connector for data output/sink
    sink_ddl = """
                    CREATE TABLE results (
                            InvoiceNo BIGINT,
                            StockCode BIGINT,
                            Description STRING,
                            Quantity INT,
                            InvoiceDate TIMESTAMP(0),
                            UnitPrice FLOAT,
                            CustomerID FLOAT,
                            Country STRING
                    ) WITH (
                                'connector' = 'filesystem',
                                'path' = 'file:///opt/input/input.csv',
                                'format' = 'csv'
                    )"""

    sink_ddl_parquet = """
                    CREATE TABLE results (
                            InvoiceNo BIGINT,
                            StockCode BIGINT,
                            Description STRING,
                            Quantity INT,
                            InvoiceDate TIMESTAMP(0),
                            UnitPrice FLOAT,
                            CustomerID FLOAT,
                            Country STRING
                    ) PARTITIONED BY (Country) WITH (
                                'connector' = 'filesystem',
                                'path' = 'file:///opt/input/input.parquet',
                                'format' = 'csv',
                                'sink.parallelism' = '1'
                    )"""

    # 创建 source Table
    table_env.execute_sql(source_ddl)

    # 创建 sink Table
    table_env.execute_sql(sink_ddl_parquet)

    # 从 SQL 查询创建一个 Table
    result_table = table_env.sql_query("SELECT * FROM MyStockTable")

    # 把查询结果发射到 sink table
    result_table.execute_insert("results")

    output_path = 'data/output/filesink_csv'

    # 如果输出目录已存在则先删除
    if os.path.exists(output_path):
        shutil.rmtree(output_path)

    # 定义 FileSink
    file_sink = FileSink \
        .for_row_format(output_path, Encoder.simple_string_encoder()) \
        .with_output_file_config(OutputFileConfig.builder().with_part_prefix('pre').with_part_suffix('-suf').build()) \
        .build()
