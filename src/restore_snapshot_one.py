import os
import boto3
import requests
import json

from datetime import date, timedelta
from requests_aws4auth import AWS4Auth


def input_env(key, default):
    if default is None or default == '':
        default = os.environ.get(key)

    if default is None or default == '':
        val = input(key + ": ")
    else:
        val = input(key + " [" + default + "]: ")

        if val == '':
            val = default

    if val is None or val == '':
        raise ValueError(key)

    return val


region = input_env("AWS_REGION", "ap-northeast-2")

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, 'es', session_token=credentials.token)

bucket = input_env("AWS_BUCKET", "")

host = input_env("ES_HOST", "")

yesterday = (date.today() - timedelta(1)).strftime('%Y.%m.%d')

snapshot = input_env("ES_SNAPSHOT", "logstash-" + yesterday)

indices = input_env("ES_INDEX", "logstash-" + yesterday)

# Restore snapshot (one index)

url = host + '_snapshot/' + bucket + '/' + snapshot + '/_restore'

payload = {'indices': indices}

headers = {'Content-Type': 'application/json'}

print('Restore snapshots : ' + snapshot + '/' + indices)

r = requests.post(url, auth=awsauth, json=payload, headers=headers)

print(json.dumps(json.loads(r.text), indent=4))
