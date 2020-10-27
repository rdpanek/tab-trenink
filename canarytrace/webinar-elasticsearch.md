# Webinář: Elasticsearch stack Demo
> Toto demo vás provede nasazením Elasticsearch v cloudu (pro ukládání dat a následné zobrazení v Kibaně), vytvořením Kubernetes clusteru v Digital Ocean pro rotaci [Canarytrace Smoke](https://quay.io/repository/canarytrace/smoke), který instantně live zapisuje výsledky smoků do Elasticsearch. Následně můžete nad daty dělat vizualizace, dashboardy, vyhledávat atp.

## Příprava
- Uvodni grafika webinare
- Zapnout nahrávání
- Aktualizovat dependencies

### Video: Elasticsearch nahrazuje HTML Reporty [Demo + Webinář]

https://youtu.be/UN5ikuJ70ZA

### Vytoč si Elasticsearch v cloudu

Dokumentace: https://canarytrace.atlassian.net/l/c/d8MGC0j1

### Vytoč si Kubernetes cluster v Digital Ocean

Dokumentace: https://canarytrace.atlassian.net/l/c/P1dqMwaP

---
> Super, pokud jsi došel/došla až jsem, tak jsi hodně naučil(a). Nyní přidáme třeba ještě monitoring dostupnosti pomocí [Heartbeat](https://www.elastic.co/beats/heartbeat) a monitorování zdrojů několika docker containerů pomocí [Metricbeat](https://www.elastic.co/beats/metricbeat)

### Vytvořit droplet na DigitalOcean
> Droplet je virtuální stroj v DigitalOcean, na kterém vytočíme nějaké docker kontejnery. 

[Použij pouze část: Create and sign in to droplet on DigitalOcean](https://canarytrace.atlassian.net/l/c/6xsXtGNT)

### Docker
Přihlaš se na svůj droplet a spusť nějaké docker kontejnery.

# Prvně si vytvoř user-defined bridges canarytrace
```
docker network create canary
```

a pak si spusť kontejnery:

**selenium**

```
docker run --name selen --net canary -d -p 5902:5900 -p 4444:4444 -p 0.0.0.0:9222:9222 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug:3.141.59-20200730
```

a **ngnix**

- před spuštěním si ještě vytvoř jednoduchý HTML soubor, který předhodíme ngnixu a který jej pak bude servírovat

```
<html>
  <head>
    <title>What is nginx?</title>
  </head>
  <body>
  <p>
    Nginx (pronounced "engine-x") is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage. It is licensed under the 2-clause BSD-like license and it runs on Linux, BSD variants, Mac OS X, Solaris, AIX, HP-UX, as well as on other *nix flavors. It also has a proof of concept port for Microsoft Windows.
  </p>
  </body>
</html>
```

a spusť

```
docker run --name nginx --rm --net canary -v $(pwd):/usr/share/nginx/html:ro -p 8080:80 -d nginx
```

**checkni, že ti selenium a ngnix běží**

Otevři prohlížeč a zkus

- pro selenium: ip-dropletu:4444
- pro ngnix: ip-dropletu:8080

> Nyní nasadíme heartbeat a metricbeat a necháme je logovat do našeho Elasticu v cloudu

**heartbeat**

Vytvoř heartbeat konfiguraci `heartbeat.docker.yml`

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

Vytvoř heartbeat docker runner `heartbeatRunner.sh`

```
#!/bin/bash

docker run --name heartbeat -d --rm --net canary \
  --volume="$(pwd)/heartbeat.docker.yml:/usr/share/heartbeat/heartbeat.yml:ro" \
  docker.elastic.co/beats/heartbeat:7.8.1 \
  -E cloud.id=canarytrace:xyz \
  -E cloud.auth=elastic:xyz
```

Nastav runner jako spustitelný

`chmod a+x chmod a+x heartbeatRunner.sh`

a spusť

`./heartbeatRunner.sh`

Nyní v Kibaně mrkni do menu a Uptime

**metricbeat**

Vytvoř konfiguraci pro metricbeat `metricbeat.docker.yml`
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

Vytvoř runner `metricRunner.sh`

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

Nastav runner jako spustitelný

`chmod a+x chmod a+x metricRunner.sh`

a spusť

`./metricRunner.sh`

Nyní v Kibaně mrkni do menu a Metrics

**Curator**

https://github.com/rdpanek/curator

---

Pokračuj ve vzdělávání a sleduj [TEST STACK Live](https://www.youtube.com/c/teststack), sleduj mě při práci a ptej se [Let's tests](https://www.twitch.tv/rdpanek/videos) a nebo se otoč [na slack](http://bit.ly/test-stack).
<br/>
<br/>
<br/>
![alt text](https://www.testautomation-basecamp.cz/tabMini.png "TEST AUTOMATION BASECAMP")
