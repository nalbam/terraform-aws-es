import boto3
import requests

from requests_aws4auth import AWS4Auth

region = '${AWS_REGION}'

userid = '${AWS_USERID}'
bucket = '${AWS_BUCKET}'

host = '${ES_HOST}'

credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, 'es', session_token=credentials.token)

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

print(r.status_code)
print(r.text)
