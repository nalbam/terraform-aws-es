# elasticsearch-snapshot

* <https://docs.aws.amazon.com/ko_kr/elasticsearch-service/latest/developerguide/es-managedomains-snapshots.html>

## prepare

```bash
sudo pip install --upgrade boto3 requests slacker requests_aws4auth
```

## variables

```bash
export DATE=$(date -v-1d '+%Y.%m.%d')

export AWS_USERID=""
export AWS_BUCKET="elasticsearch-snapshot"

export ES_HOST="http://elasticsearch.dev.opsnow.com/"

export ES_SNAPSHOT="logstash-${DATE}"
export ES_INDEX="logstash-${DATE}"
```

## snapshot

```bash
# get
curl -sL -XGET "${ES_HOST}_snapshot?pretty" | jq .
curl -sL -XGET "${ES_HOST}_snapshot/cs-automated/_all?pretty" | jq .
curl -sL -XGET "${ES_HOST}_snapshot/${AWS_BUCKET}/_all?pretty" | jq .
curl -sL -XGET "${ES_HOST}_snapshot/${AWS_BUCKET}/${ES_SNAPSHOT}?pretty" | jq .

# take snapshot
curl -sL -XPUT "${ES_HOST}_snapshot/${AWS_BUCKET}/${ES_SNAPSHOT}"

# restore
curl -sL -XPOST "${ES_HOST}_snapshot/${AWS_BUCKET}/${ES_SNAPSHOT}/_restore"

# delete shapshot
# curl -sL -XDELETE "${ES_HOST}_snapshot/${AWS_BUCKET}/${ES_SNAPSHOT}"
```
