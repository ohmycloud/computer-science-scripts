from impala.dbapi import connect

# pip install impyla
if __name__ == '__main__':
    # 得到连接，
    conn = connect(host='127.0.0.1', port=10000, auth_mechanism='PLAIN', user='xx',
                   password='xxx',  database='xxx')
    cursor = conn.cursor()
    cursor.execute('select * from test limit 5 ')
    for result in cursor.fetchall():
        print(result)
    cursor.close()
    conn.close()
