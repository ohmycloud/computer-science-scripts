import json_tools

def json_diff(json_1, json_2):
    result = json_tools.diff(json_1, json_2)
    print(result)

a = {"rd": "yanan", "pro": {"sh": "shandong", "city": ["zibo", "weifang"]}}
b = {"rd": "Yanan", "pro": {"sh": "shandong", "town": ["taian", "weifang"]}}

json_diff(a, b)