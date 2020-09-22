# Workshop: Elasticsearch stack

## DO demo heartbeat a metricbeat

### heartbeat

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
