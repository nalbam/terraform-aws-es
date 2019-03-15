import os
import boto3
import requests

from datetime import date, timedelta
from requests_aws4auth import AWS4Auth

# userid = '${AWS_USERID}'  # os.environ.get('AWS_USERID')
bucket = '${AWS_BUCKET}'  # os.environ.get('AWS_BUCKET')
region = '${AWS_REGION}'  # os.environ.get('AWS_REGION', 'ap-northeast-2')

service = 'es'
host = '${ES_HOST}'  # os.environ.get('ES_HOST')

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

# Take snapshot

yesterday = date.today() - timedelta(1)
date_time = yesterday.strftime('%Y.%m.%d')

snapshot = 'logstash-' + date_time

url = host + '_snapshot/' + bucket + '/' + snapshot

print('Take snapshot : ' + snapshot)

r = requests.put(url, auth=awsauth)

print(r.text)
