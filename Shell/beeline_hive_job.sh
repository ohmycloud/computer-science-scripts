#!/bin/bash

job_name=$(basename "$0" | awk -F . '{print $1}')

for table in $(cat input.txt)
do
    oem_name=$(echo "${table}" | awk -F '_' '{print $2}')
    echo "执行数据: ${oem_name}"
    beeline -u jdbc:hive2://datahouse-master2:10000 -n hadoop --hiveconf spark.app.name="${job_name}_${table}" --hiveconf hive.table.name="${table}" --hiveconf hive.oem.name="${oem_name}" -f etl_from_alg_to_datahouse.sql.sql
    if [[ $? -ne 0 ]]; then
      echo "${table} finally failed"
    else
      echo "${table} finally successed"
    fi
done
