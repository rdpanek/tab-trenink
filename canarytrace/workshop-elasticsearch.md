# Workshop: Elasticsearch stack

## Příprava

**Droplet**
- Vytvořit droplet na DigitalOcean

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

**metricbeat**

metricbeat.docker.yml
```
metricbeat.autodiscover:
  providers:
    - type: docker
      hints.enabled: true

metricbeat.modules:
- module: docker
  metricsets:
    - "container"
    - "cpu"
    - "diskio"
    - "healthcheck"
    - "info"
    #- "image"
    - "memory"
    - "network"
  hosts: ["unix:///var/run/docker.sock"]
  period: 10s
  enabled: true

processors:
  - add_cloud_metadata: ~

output.elasticsearch:
  hosts: '${ELASTICSEARCH_HOSTS:elasticsearch:9200}'
  username: '${ELASTICSEARCH_USERNAME:}'
  password: '${ELASTICSEARCH_PASSWORD:}'
```

metricRunner.sh

```
#!/bin/bash

docker run --name metricbeat -d --rm  \
  --name=metricbeat \
  --user=root \
  --volume="$(pwd)/metricbeat.docker.yml:/usr/share/metricbeat/metricbeat.yml:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  --volume="/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro" \
  --volume="/proc:/hostfs/proc:ro" \
  --volume="/:/hostfs:ro" \
  docker.elastic.co/beats/metricbeat:7.8.1 metricbeat -e \
  -E cloud.id=canarytrace:xzy \
  -E cloud.auth=elastic:xyz
```
