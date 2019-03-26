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

indices = input_env("ES_INDEX", "logstash-" + yesterday)

# Delete index

url = host + indices

print('Delete index : ' + indices)

r = requests.delete(url, auth=awsauth)

print(json.dumps(json.loads(r.text), indent=4))
