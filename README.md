# terraform-aws-elasticsearch

## Create elasticsearch

```bash
# terraform
brew install terraform

# python lib
sudo pip install --upgrade boto3 requests slacker requests_aws4auth
# or
sudo pip3 install --upgrade boto3 requests slacker requests_aws4auth

# env
cd env/dev-demo

# terraform (5m)
terraform init
terraform plan
terraform apply
```

## Take snapshot

### variables

```bash
export AWS_BUCKET="elasticsearch-snapshot"

export ES_HOST="http://elasticsearch.dev.opsnow.com/"
```

### snapshot

```bash
# Register repository
python3 snapshot/register_repo.py

# Take snapshot
python3 snapshot/take_snapshot.py


```

* <https://docs.aws.amazon.com/ko_kr/elasticsearch-service/latest/developerguide/es-managedomains-snapshots.html>
