import os
import boto3
import requests
import sys
import getopt

from requests_aws4auth import AWS4Auth

# userid = '${AWS_USERID}'  # os.environ.get('AWS_USERID')
bucket = '${AWS_BUCKET}'  # os.environ.get('AWS_BUCKET')
region = '${AWS_REGION}'  # os.environ.get('AWS_REGION', 'ap-northeast-2')

service = 'es'
host = '${ES_HOST}'  # os.environ.get('ES_HOST')
snapshot = '${ES_SNAPSHOT}'  # os.environ.get('ES_SNAPSHOT')
# indices = '${ES_INDEX}'  # os.environ.get('ES_INDEX')

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

# Restore snapshots (all indices)

url = host + '_snapshot/' + bucket + '/' + snapshot + '/_restore'

print('Restore snapshots : ' + snapshot)

r = requests.post(url, auth=awsauth)

print(r.text)
