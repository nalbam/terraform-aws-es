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

client = boto3.client("sts")
userid = client.get_caller_identity()["Account"]

userid = input_env("AWS_USERID", userid)
bucket = input_env("AWS_BUCKET", "")

host = input_env("ES_HOST", "")

# Register repository

url = host + '_snapshot/' + bucket

role_arn = 'arn:aws:iam::' + userid + ':role/' + bucket

payload = {
    'type': 's3',
    'settings': {
        'bucket': bucket,
        'region': region,
        'role_arn': role_arn
    }
}

headers = {'Content-Type': 'application/json'}

print('Register repository : ' + bucket)

r = requests.put(url, auth=awsauth, json=payload, headers=headers)

print(json.dumps(json.loads(r.text), indent=4))
