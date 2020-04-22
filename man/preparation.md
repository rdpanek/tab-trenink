# TAB - PREPARATION

![alt text](https://github.com/rdpanek/tab-trenink/raw/master/man/mindMap.jpeg "MindMap")

## 1). Run DO droplets

## Example s WPT

- Vysvetlit, jak funguje test automatizace frontendu
- konvencni frameworky
- web performance test / a jak funguje wpt
- jak se sestavuje test stack
- misto toho pouzit docker


Spusti selenium v dockeru
docker run --name selen -d -p 4444:4444 -v /dev/shm:/dev/shm selenium/standalone-chrome:3.141.59-yttrium

Clone wpt2-demo
https://github.com/rdpanek/wpt2-demo.git

- v `runner.sh` odstranit elastic
- spustit test

# Pridat do hry Elastic

- `sysctl -w vm.max_map_count=262144`
- `docker run --name elastic -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.7.1 bin/elasticsearch -Enetwork.host=0.0.0.0`
- `docker run --name kibana -d --link elastic:elasticsearch -p 5601:5601 docker.elastic.co/kibana/kibana:6.7.1`
ottps://github.com/rdpanek/wpt2-demo.git
- projit elasticsearch, logy a kibanu
- nahrat mapping pro wpt2-performance-entries index
- spustit test
- v Kibane vytvorit index patterns `wpt2-performance-entries-*` a `wpt2-report-*`

# Rotace
- v runneru nastavit vice otocek, napr. 10
- pridat do runneru selen docker kill and run

# Vizualizace
- vytvorit vizualizace v Kibane

# Uprav si test podle sveho

# Tvorba vlastniho docker image
- Tvorba `Dockerfile`
```
FROM rdpanek/wpt2-demo:d.2.18
MAINTAINER Radim Daniel Pánek <rdpanek@gmail.com>

ENV APP_DIR /opt/wpt2/
ENV TEST_DIR ${APP_DIR}/test/

# Create app directory
RUN mkdir -p ${APP_DIR} && \
    chown -R node:node ${APP_DIR} && \
    mkdir -p ${TEST_DIR}
WORKDIR ${APP_DIR}
COPY test/ ${TEST_DIR}
RUN ls -lah $APP_DIR && \
    ls -lah $TEST_DIR/performanceTesting

USER node

ENTRYPOINT [ "./node_modules/.bin/wdio" ]
```

- Build (vlastnik/framework:verze) vlastnik = user na dockerhub
`docker build -t rdpanek/framework:1.0 .`
- Push do dockerhub
    - `docker login`
    - docker push `docker push rdpanek/framework:1.0`
- uprava `runner.sh` a pouzit vlastni docker image
- spustit rotaci

# Minikube
- Install `kubectl`
    - `curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl`
    - chmod +x ./kubectl
    - ./kubectl
    - `sudo apt-get update && sudo apt-get upgrade && sudo apt-get install -y apt-transport-https gnupg2`
- Install `minikube`
    - `curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube`
    - `sudo mkdir -p /usr/local/bin/`
    - `sudo install minikube /usr/local/bin/`
    - `minikube start --vm-driver=none`

## 2). Install Elasticsearch & Kibana

## 3). WDIO tests

## 4). RUN test

## 5). Custom Dockerfile

## 6). Push to dockerhub

## 7). Run custom dockerfile

## 8). Kubernetes
