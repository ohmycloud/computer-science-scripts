# -*- encoding: utf-8 -*-

import polars as pl
import click
from impala.dbapi import connect


def target_capacity(input_path, sheet_name):
    dtypes = {
        '订单编号': pl.Categorical,
        '枪头编号': pl.Categorical,
        'SOC': pl.Categorical,
        '充电开始时间': pl.Categorical,
        '充电结束时间': pl.Categorical,
        '充电量': pl.Float64,
        '模块编号': pl.Categorical,
        '订单时长': pl.Int64,
        '平台订单号': pl.Categorical,
        '平台起始SOC': pl.Float64,
        '平台结束SOC': pl.Float64,
        '平台输出能量': pl.Float64,
        'brm_vin': pl.Categorical,
        '电量差': pl.Float64
    }
    dicts = pl.read_excel(
        input_path,
        sheet_name=sheet_name,
        xlsx2csv_options={"skip_empty_lines": True},
        read_csv_options={"has_header": True, "dtypes": dtypes}
    ).to_dicts()

    conn = connect(host='datahouse-master2', port=10000, auth_mechanism='PLAIN', user="hadoop")
    cursor = conn.cursor()
    data = []

    dt_set = set({})
    order_id_set = set({})
    device_id_set = set({})

    for d in dicts:
        device_id = d['模块编号']
        order_id = d['平台订单号']
        dt = order_id[8:16]
        dt_set.add(dt)
        order_id_set.add(order_id)
        device_id_set.add(device_id)


    dt_list = ','.join(list(map(lambda x: f"'{x}'", list(dt_set))))
    order_id_list = ','.join(list(map(lambda x: f"'{x}'", list(order_id_set))))
    device_id_list = ','.join(list(map(lambda x: f"'{x}'", list(device_id_set))))

    sql_query_string = f"select order_id, rel_time, ccs_out_volt, ccs_out_current, bcs_volt_measure, bcs_current_measure from dwd.dwd_wcd_pile_data_detail_dupli_di where dt in ({dt_list}) and device_id in ({device_id_list}) and order_id in ({order_id_list}) order by order_id, rel_time"
    print(sql_query_string)
    cursor.execute(sql_query_string)
    results = cursor.fetchall()
        
    for row in results:
        order_id = row[0]
        rel_time = row[1]
        ccs_out_volt = row[2]
        ccs_out_current = row[3]
        bcs_volt_measure = row[4]
        bcs_current_measure = row[5]
        if order_id != None:
            data.append({
                'orderId': order_id,
                'relativeTime': rel_time,
                'ccsOutVolt': ccs_out_volt,
                'ccsOutCurrent': ccs_out_current,
                'bcsVoltMeasure': bcs_volt_measure,
                'bcsCurrentMeasure': bcs_current_measure
            })

    cursor.close()
    conn.close()

    return pl.from_dicts(data).select(
        [
            pl.col('orderId').cast(pl.Utf8),
            pl.col('relativeTime').cast(pl.Utf8),
            pl.col('ccsOutVolt').cast(pl.Float64),
            pl.col('ccsOutCurrent').cast(pl.Float64),
            pl.col('bcsVoltMeasure').cast(pl.Float64),
            pl.col('bcsCurrentMeasure').cast(pl.Float64)
        ]
    )


def fill_null(df):
    return (df.sort(['orderId', 'relativeTime'])
              .fill_null(strategy="forward")
    )

def ccs_data(df: pl.DataFrame):
    return (df.select([
                      pl.col('orderId'),
                      pl.col('relativeTime'),
                      pl.col('ccsOutVolt'),
                      pl.col('ccsOutCurrent')
                   ]).unique(subset=['orderId', 'relativeTime', 'ccsOutVolt','ccsOutCurrent'], maintain_order=True))


def ccs_adadpter(df: pl.DataFrame):
    return (df.with_columns([(pl.col("ccsOutVolt") * pl.col('ccsOutCurrent').abs()).alias('power')]))


def ccs_capacity_stat(df: pl.DataFrame):
    return (df.groupby('orderId') \
               .agg([
                (pl.col("ccsOutVolt") * pl.col("ccsOutCurrent")).sum().alias("ccs_total_power"),
                ((pl.col("ccsOutVolt") * pl.col("ccsOutCurrent")).sum() / 3600000.0).alias("ccs_capacity")
               ]))

def bcs_data(df: pl.DataFrame):
    return (df.select([
                    pl.col('orderId'),
                    pl.col('relativeTime'),
                    pl.col('bcsVoltMeasure'),
                    pl.col('bcsCurrentMeasure')
               ]).unique(subset=['orderId', 'relativeTime', 'bcsVoltMeasure','bcsCurrentMeasure'], maintain_order=True))

def bcs_adater(df: pl.DataFrame):
    return (df.with_columns([(pl.col("bcsVoltMeasure") * pl.col('bcsCurrentMeasure').abs()).alias('power')]))

def bcs_capacity_stat(df: pl.DataFrame):
    return (df.groupby('orderId') \
               .agg([
                 (pl.col("bcsVoltMeasure") * pl.col("bcsCurrentMeasure")).sum().alias("bcs_total_power"),
                 ((pl.col("bcsVoltMeasure") * pl.col("bcsCurrentMeasure")).sum() / 3600000.0).alias("bcs_capacity")
               ]))

def max_by_power(df: pl.DataFrame):
    return (df.with_columns([
        pl.col("power").max().over("relativeTime").alias("max_power")
    ]))

def remove_rows(df: pl.DataFrame):
    return (df.filter(pl.col('power') == pl.col('max_power')))

@click.command()
@click.option('--input-path', help='输入文件路径')
@click.option('--sheet-name', default='Sheet1', help='name of worksheet')
@click.option('--table-col', default=3, help='表格列数')
def stat(input_path, sheet_name, table_col):        
    with pl.Config() as cfg:
        cfg.set_tbl_cols(table_col)
        #df = target_capacity(input_path, sheet_name)
        dtypes = {
            'order_id': pl.Categorical,
            'rel_time': pl.Categorical,
            'ccs_out_volt': pl.Float64,
            'ccs_out_current': pl.Float64,
            'bcs_volt_measure': pl.Float64,
            'bcs_current_measure': pl.Float64
        }
        df = pl.scan_csv(input_path, has_header=True,dtypes=dtypes,null_values='NULL').select([
            pl.col('order_id').alias('orderId'),
            pl.col('rel_time').alias('relativeTime'),
            pl.col('ccs_out_volt').alias('ccsOutVolt'),
            pl.col('ccs_out_current').alias('ccsOutCurrent'),
            pl.col('bcs_volt_measure').alias('bcsVoltMeasure'),
            pl.col('bcs_current_measure').alias('bcsCurrentMeasure')
        ])

        ccs_df = df.pipe(ccs_data) \
                   .pipe(fill_null) \
                   .pipe(ccs_adadpter) \
                   .pipe(max_by_power) \
                   .pipe(remove_rows) \
                   .drop(['power', 'max_power'])

        ccs_capacity = df.pipe(ccs_capacity_stat)

        bcs_df = df.pipe(bcs_data) \
                   .pipe(fill_null) \
                   .pipe(bcs_adater) \
                   .pipe(max_by_power) \
                   .pipe(remove_rows) \
                   .drop(['power', 'max_power'])

        bcs_capacity = df.pipe(bcs_capacity_stat)          

        ccs_capacity.collect().write_excel('ccs_capacity.xlsx')
        bcs_capacity.collect().write_excel('bcs_capacity.xlsx')        

if __name__ == '__main__':
    stat()
