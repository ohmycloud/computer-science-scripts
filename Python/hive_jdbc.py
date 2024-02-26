from hivejdbc import connect


if __name__ == '__main__':
    conn = connect(
        host='127.0.0.0',
        database='test',
        port=10000,
        user='hadoop',
        driver=r'hive-jdbc-uber-2.6.5.0-292.jar',

    )

    cursor = conn.cursor()
    query = '''select * from test limit 10'''

    cursor.execute(query)
    for row in cursor:
        print(row)
    cursor.close()
