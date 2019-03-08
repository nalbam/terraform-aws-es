import os
import boto3
import requests
from requests_aws4auth import AWS4Auth

userid = '${AWS_USERID}'  # os.environ.get('AWS_USERID')
bucket = '${AWS_BUCKET}'  # os.environ.get('AWS_BUCKET')
region = '${AWS_REGION}'  # os.environ.get('AWS_REGION', 'ap-northeast-2')

service = 'es'
host = '${ES_HOST}'  # os.environ.get('ES_HOST')

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

# Register repository

url = host + '_snapshot/' + bucket  # the Elasticsearch API endpoint

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

print(r.status_code)
print(r.text)
