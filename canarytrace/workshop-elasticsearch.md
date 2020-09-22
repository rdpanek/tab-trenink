# Workshop: Elasticsearch stack

## Příprava
- Spustit nahrávání Google Meet

**Droplet**
- Vytvořit droplet na DO z uloženého image

**Docker**
- Spustit nějaké docker kontejnery

**heartbeat**

heartbeat.docker.yml

```
heartbeat.monitors:
- type: http
  schedule: '@every 1s'
  urls:
    - http://selen:4444
    - https://canarytrace.com

processors:
- add_cloud_metadata: ~

output.elasticsearch:
  hosts: '${ELASTICSEARCH_HOSTS:elasticsearch:9200}'
  username: '${ELASTICSEARCH_USERNAME:}'
  password: '${ELASTICSEARCH_PASSWORD:}'
```

heartbeatRunner.sh

```
#!/bin/bash

docker run --name heartbeat -d --rm --net canary \
  --volume="$(pwd)/heartbeat.docker.yml:/usr/share/heartbeat/heartbeat.yml:ro" \
  docker.elastic.co/beats/heartbeat:7.8.1 \
  -E cloud.id=canarytrace:xyz \
  -E cloud.auth=elastic:xyz
```
