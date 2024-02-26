# -*- coding: utf-8 -*-

import polars as pl


def set_types(df: pl.DataFrame) -> pl.DataFrame:
    """设置类型
    """
    return (df
            .with_columns([
                pl.col("vin").cast(pl.Int32)
            ]))

def threshold_config() -> dict:
    """配置阈值
    """
    return {
        'ts': 5,
        'soc': 5,
        'mileage': 5
    }

def create_data() -> pl.DataFrame:
    """创建测试数据
    """
    return (
        pl.DataFrame({
            'vin': [*['aa' for _ in range(0, 10)], *['bb' for _ in range(0, 10)]],
            'ts': [1685686645,1685686646,1685686647,1685686648,1685686649,1685686650,1685686655,1685686656,1685686657,1685686658,1685686659,1685686660,1685686661,1685686662,1685686663,1685686664,1685686665,1685686666,1685686667,1685686668],
            'soc': [20,21,25,28,29,30,33,36,37,38,80,79,78,73,72,69,66,65,64,63],
            'mileage': [2,4,8,9,10,11,12,13,16,20,21,22,23,24,25,26,27,28,29,30],
        })
    )

def sessionize(df: pl.DataFrame) -> pl.DataFrame:
    """session 划分
    :param df: polars DataFrame
    """
    threshold_dict = threshold_config()
    return (df
            .sort(["vin", "ts"])
            .with_columns([
                (pl.col("ts").diff() >= threshold_dict['ts']).fill_null(True).alias("ts_diff"),
                (pl.col("soc").diff().abs() >= threshold_dict['soc']).fill_null(True).alias("soc_diff"),
                (pl.col("mileage").diff() >= threshold_dict['mileage']).fill_null(True).alias("mileage_diff"),
                (pl.col("vin").hash(1,1,1,1).diff() != 0).fill_null(True).alias("vin_diff")
            ])
            .with_columns([
                (pl.col("ts_diff") | pl.col("soc_diff") | pl.col("mileage_diff") | pl.col("vin_diff")).alias("new_session_mark")
            ])
            .with_columns([
                pl.col("new_session_mark").cumsum().alias("session"),
                pl.col("new_session_mark").cumsum().over("vin").alias("n_segment")
            ])
            .drop(["ts_diff", "soc_diff", "new_session_mark", "vin_diff"])
    )

def add_features(df: pl.DataFrame) -> pl.DataFrame:
    """添加统计功能
    :param df: polars DataFrame
    """
    return (df
            .with_columns([
                pl.col("vin").count().over("session").alias("session_length"),
                pl.col("ts").first().over("session").alias("session_start"),
                pl.col("ts").last().over("session").alias("session_end"),
                pl.col("session").n_unique().over("vin").alias("n_sessions")
            ])
    )

def remove_invalid(df: pl.DataFrame, threshold=5) -> pl.DataFrame:
    """移除无效的 session
    """
    n_rows = threshold * 1
    return (df
            .filter(pl.col("session_length") > n_rows)
    )

if __name__ == '__main__':
    """数据打 session 标签
    """
    df = create_data()
    print(df)
    s_df = df.pipe(sessionize) \
             .pipe(add_features)
    print(s_df)
    s_df.write_excel('session-all.xlsx')
    s_df.pipe(remove_invalid).write_excel('session-valid.xlsx')
