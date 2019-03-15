# backup & restore

* 스냅샷은 증분 저당 된다.

* <https://docs.aws.amazon.com/ko_kr/elasticsearch-service/latest/developerguide/es-managedomains-snapshots.html>

## prepare

```bash
sudo pip install --upgrade requests
sudo pip install --upgrade requests_aws4auth
sudo pip install --upgrade boto3
```

## variables

```bash
export DATE=$(date -v-1d '+%Y.%m.%d')

export AWS_USERID="759871273906"
export AWS_BUCKET="seoul-sre-k8s-elasticsearch-snapshot"

export ES_HOST="http://seoul-sre-k8s-elasticsearch.opsnow.io/"
export ES_SNAPSHOT="logstash-2019.01.16"
export ES_INDEX="logstash-2019.01.16"
```

## 스냅샷 조회 및 복원

```bash
endpoint=
repository=
snapshot=

curl -XGET "${endpoint}/_snapshot?pretty"
curl -XGET "${endpoint}/_snapshot/cs-automated/_all?pretty"

curl -XPOST "${endpoint}/_snapshot/${repository}/${snapshot}/_restore"
```

## 스냅샷 저장소 등록 (최초 ES 설치 후 실행)

```bash
python3 register-repo.py

Register repository : seoul-sre-k8s-elasticsearch-snapshot
200
{"acknowledged":true}
```

## 스냅샷 기록 (매일 UTC 0 배치)

```bash
python3 take-snapshot.py

# 성공
Take snapshot : logstash-2019.01.16
{"accepted":true}

# 실패 (중복)
Take snapshot : logstash-2019.01.16
{"error":{"root_cause":[{"type":"invalid_snapshot_name_exception","reason":"[seoul-sre-k8s-elasticsearch-snapshot:logstash-2019.01.16] Invalid snapshot name [logstash-2019.01.16], snapshot with the same name already exists"}],"type":"invalid_snapshot_name_exception","reason":"[seoul-sre-k8s-elasticsearch-snapshot:logstash-2019.01.16] Invalid snapshot name [logstash-2019.01.16], snapshot with the same name already exists"},"status":400}
```

## 스냅샷 복원 (all indices)

```bash
python3 restore-snapshot-all.py

Restore snapshots : logstash-2019.01.16
{"accepted":true}
```

## 스냅샷 복원 (one index)

```bash
python3 restore-snapshot-one.py

Restore snapshots : logstash-2019.01.16/logstash-2019.01.16
{"accepted":true}
```

## 인덱스 삭제

```bash
python3 remove-index.py

# 성공
Delete index : logstash-2019.01.01
{"accepted":true}

# 실패
Delete index : logstash-2018.12.08
{"error":{"root_cause":[{"type":"index_not_found_exception","reason":"no such index","resource.type":"index_or_alias","resource.id":"logstash-2018.12.08","index_uuid":"_na_","index":"logstash-2018.12.08"}],"type":"index_not_found_exception","reason":"no such index","resource.type":"index_or_alias","resource.id":"logstash-2018.12.08","index_uuid":"_na_","index":"logstash-2018.12.08"},"status":404}
```
