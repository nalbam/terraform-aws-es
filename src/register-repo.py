import os
import boto3
import requests
from requests_aws4auth import AWS4Auth

userid = os.environ.get('AWS_USERID')  # 759871273906
bucket = os.environ.get('AWS_BUCKET')  # seoul-sre-k8s-elasticsearch-snapshot
region = os.environ.get('AWS_REGION', 'ap-northeast-2')

service = 'es'
host = os.environ.get('ES_HOST')  # http://sre-k8s-elasticsearch.opsnow.io/
# snapshot = os.environ.get('ES_SNAPSHOT')  # logstash-2019.01.14
# indices = os.environ.get('ES_INDEX')  # logstash-2019.01.14

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

# Register repository

path = '_snapshot/' + bucket  # the Elasticsearch API endpoint
url = host + path

role_arn = 'arn:aws:iam::' + userid + ':role/' + bucket

payload = {
    "type": "s3",
    "settings": {
        "bucket": bucket,
        "region": region,
        "role_arn": role_arn
    }
}

headers = {"Content-Type": "application/json"}

print('Register repository : ' + bucket)

r = requests.put(url, auth=awsauth, json=payload, headers=headers)

print(r.status_code)
print(r.text)
