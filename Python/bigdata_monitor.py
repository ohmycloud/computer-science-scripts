# -*-coding: utf-8 -*-

import urllib.request
import json
import logging
import smtplib
from email.mime.text import MIMEText
from email.header import Header


logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s  %(filename)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
logger = logging.getLogger(__name__)


mail_host = "smtp.exmail.qq.com"
mail_user = "xxx@zzz.net.cn"
mail_pass = "xxx"

sender = "xxx@zzz.net.cn"
receivers = ["xxx@zzz.net.cn"]


# 获取 application id 和 tracking_url
def get_application_list():
    url = "http://127.0.0.1:8099/ws/v1/cluster/apps?queue=root.users.hdfs"
    req = urllib.request.Request(url)
    text = urllib.request.urlopen(req).read()
    apps = json.loads(text)
    tracking_url = ''
    application_id = ''
    app_list = []
    alarm_list = []

    for app in apps['apps']['app']:
        if app['state'] == 'RUNNING':
            if app['name'] == 'yyy' or app['name'] == 'kkk':
                app_list.append(app['name'])

    if app_list.count('yyy') != 2:
        alarm_list.append('yyy')

    if app_list.count('kkk') == 1:
        alarm_list.append('kkk')

    return alarm_list



# 发送告警邮件
def send_email(text):
    message = MIMEText(text + ' 可能掉线了, 请尽快排查!', 'plain', 'utf-8')
    message['From'] = Header("检测到以下任务异常", 'utf-8')
    message['To'] =  Header("报警邮件", 'utf-8')
    subject = '大数据程序异常'
    message['Subject'] = Header(subject, 'utf-8')

    try:
        smtpObj = smtplib.SMTP()
        smtpObj.connect(mail_host)
        smtpObj.login(mail_user, mail_pass)
        smtpObj.sendmail(sender, receivers, message.as_string())
        print("邮件发送成功")
    except smtplib.SMTPException:
        print("邮件发送失败")

# python job_monitor.py
if __name__ == '__main__':
    running_app_list = get_application_list()
    if len(running_app_list) > 0:
        send_email(str(running_app_list))
