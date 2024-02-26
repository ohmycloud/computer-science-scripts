import json
import requests
from requests.exceptions import HTTPError
import logging
import os

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s  %(filename)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
logger = logging.getLogger(__name__)

def app_log(f):
    for x in f.read():
        logger.info(x)

def restart_app():
    f = os.popen("sh /opt/bigdata/app")
    app_log(f)

def app_response():
    ws_url = 'http://host1:8099/ws/v1/cluster/apps/?state=running'
    try:
        response = requests.get(ws_url)
        json_app = response.json()
        return json_app
    except HTTPError as http_err:
        logger.warn(f'HTTP error occurred: {http_err}')
        return {}
    except Exception as err:
        logger.warn(f'Other error occurred: {err}')
        return {}

def running_apps():
    running = []

    for i in range(3):
        json_app = app_response()
        if len(json_app) > 0:
            app_name = [ app['name'] for app in json_app['apps']['app'] ]
            if 'xxx' not in app_name:
                logger.warn("xxx dead!")
                running.append(1)

        os.popen('sleep 10').read()

    if len(running) >= 2:
        restart_app()

if __name__ == '__main__':
    running_apps()
