import json
import re
import base64

s = """
{"@timestamp":"2022-07-12T10:34:23.240Z","@metadata":{"beat":"filebeat","type":"_doc","version":"7.13.3"},"track_data":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjIjp7ImNsaWVudFNvdXJjZSI6InRlc3QiLCJhcHBLZXkiOiIxMjMiLCJjbGllbnRWZXJzaW9uIjoiMC4wLjEtU05BUFNIT1QiLCJ0cyI6MTY1NzYyMTMzOTQ1MiwiY2xpZW50SG9zdE5hbWUiOiIxMC4wLjMuMTYwIiwiY2xpZW50SXAiOiIxMC4wLjMuMTYwIn0sImV2ZW50IjoidGVzdCIsInByb3BlcnRpZXMiOnsiMSI6IjEiLCIyIjoiMiJ9fQ.eTIf7P3p_galsTeAgPH41_tQiz8KcZAyQnAMo-oma9U"}
"""

def json_data(token: str):
    padded = token + "="*divmod(len(token),4)[1]
    jsondata = base64.urlsafe_b64decode(padded)    
    return json.loads(jsondata)

# https://blog.csdn.net/qq_45076180/article/details/107243172
# https://stackoverflow.com/questions/64616462/decode-jwt-header-python
d = json.loads(s)

jwt_token = d['track_data']

res = re.split(r"[.]", jwt_token)

for token in res[0:2:1]:
    print(json_data(token))
