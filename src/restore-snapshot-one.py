import os
import boto3
import requests
from requests_aws4auth import AWS4Auth

# userid = os.environ.get('AWS_USERID')  # 759871273906
bucket = os.environ.get('AWS_BUCKET')  # seoul-sre-k8s-elasticsearch-snapshot
region = os.environ.get('AWS_REGION', 'ap-northeast-2')

service = 'es'
host = os.environ.get('ES_HOST')  # http://sre-k8s-elasticsearch.opsnow.io/
snapshot = os.environ.get('ES_SNAPSHOT')  # logstash-2019.01.14
indices = os.environ.get('ES_INDEX')  # logstash-2019.01.14

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

# Restore snapshot (one index)

path = '_snapshot/' + bucket + '/' + snapshot + '/_restore'
url = host + path

payload = {"indices": indices}

headers = {"Content-Type": "application/json"}

print('Restore snapshots : ' + snapshot + '/' + indices)

r = requests.post(url, auth=awsauth, json=payload, headers=headers)

print(r.text)
