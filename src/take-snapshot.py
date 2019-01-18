import os
import boto3
import requests
from datetime import date, timedelta
from requests_aws4auth import AWS4Auth

# userid = os.environ.get('AWS_USERID')  # 759871273906
bucket = os.environ.get('AWS_BUCKET')  # seoul-sre-k8s-elasticsearch-snapshot
region = os.environ.get('AWS_REGION', 'ap-northeast-2')

service = 'es'
host = os.environ.get('ES_HOST')  # http://sre-k8s-elasticsearch.opsnow.io/
# snapshot = os.environ.get('ES_SNAPSHOT')  # logstash-2019.01.14
# indices = os.environ.get('ES_INDEX')  # logstash-2019.01.14

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

# Take snapshot

yesterday = date.today() - timedelta(1)
date_time = yesterday.strftime("%Y.%m.%d")

snapshot = 'logstash-' + date_time

path = '_snapshot/' + bucket + '/' + snapshot
url = host + path

print('Take snapshot : ' + snapshot)

r = requests.put(url, auth=awsauth)

print(r.text)
