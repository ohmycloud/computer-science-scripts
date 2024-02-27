set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions=20000;
set hive.exec.max.dynamic.partitions.pernode=2000;
set parquet.memory.min.chunk.size= 65536;
use temp;

with tmp_oem as (
    select `real_time`        ,
        `timestamp`           ,
        `volt`                ,
        `current`             ,
        `soc`                 ,
        `charge_st`           ,
        `veh_spd`             ,
        `mileage`             ,
        `lon`                 ,
        `lat`                 ,
        `single_volt_list`    ,
        `single_temp_list`    ,
        `charge_num`          ,
        `even`                ,
        `odd`                 ,
        '${hiveconf:hive.oem.name}' as oem,
        `vin`                 ,
        DATE_FORMAT(real_time, 'Y') as y
        from ${hiveconf:hive.table.name}
)

insert overwrite table dwd.dwd_alg_car_detail_csf_yi partition(oem, vin, y)
select * from tmp_oem;
