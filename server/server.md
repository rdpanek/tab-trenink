# TAB - SERVER

## 1). Run DO droplets
- Instalace Dropletu (virtuální stroj)
- Spuštění dropletu pro účastníky z uloženého image
- Můžeš experimentovat a pak stroj zabít nebo jen vypnout

**Linux**
- operační systém
    - principy a využití
    - distribuce běžné, minimální, povolené/ověřené například v openshift
- programy a syntaxe
    - `java -jar selenium-server-standalone-3.141.59.jar -Dwebdriver.chrome.driver=./chromedriver80`
    - `git pull origin2 panek-ui-tests`
    - `tail -f -n1000 ./myLog.log`
- příkazy `ls`, `pwd`, `cd`, `cat`, `less`, `vim`, `cp`, `mv`, `scp`, `history`, `tail`, `curl`, `apt-get install`, `apt update`, `apt upgrade`, `echo`, `ssh`, 
- `Control+C`
- relativní a absolutní cesta
- stdout a stderr
- VNC
- jumpserver / protunelování
- přihlášení

**WDIO**
- popsat WDIO
- nainstalovat a spustit si test https://webdriver.io/docs/gettingstarted.html
- jak to šlo? dost pracné, co stím?

## 2). Git
- popsat Git
- ukazat tig `tig --all`
- top prikazy `clone`,`status`,`commit`,`push`,`pull`,`rebase`,`stash`,`reset`
- větvení, git-flow https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow
- konflikty

Clone wpt2-demo
https://github.com/rdpanek/wpt2-demo.git

- co jste naklonovali, co to dělá?
- v `runner.sh` odstranit elastic
- spustit test

## 3). Docker
- co a k čemu to je? => Playstation
- windows, Linux, Unix
- use cases
- terminologie a příkazy `run`,`start`,`stop`,`kill`,`rm`,`images`,`logs` 
- example1 `docker run --name test -it --rm -e MY_ENV=AHOJ ubuntu`
- example2
    - `mkdir www`
    - `touch www/index.html`
    - `vim www/index.html`
    - přidej text `<H1>Muj prvni webovy server</H1>`
    - zjisti si absolutní cestu `pwd`
    - `docker run --name nginx -v /Users/rdpanek/HTDOCS/temp/www:/usr/share/nginx/html:ro -d -p 8080:80 nginx`
    - do browseru zadej `localhost:8080`
    - `docker logs -f nginx`
- použití v test automatizaci, rotace testů, klonování git repozitáře = jak dostat testy do kontejneru?

**Pokračování v příkladu**
Spusti selenium v dockeru
docker run --name selen -d -p 4444:4444 -v /dev/shm:/dev/shm selenium/standalone-chrome:3.141.59-yttrium


## 2). Rotace
- v `runner.sh` nastavit vice otoček, napr. 10
- přidat do `runner.sh` selen docker kill and run
```
docker kill selen
docker rm selen
docker run --name selen -d -p 5902:5900 -p 4444:4444 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug:3.141.59-titanium
```

## 3). Pridat do hry Elastic

- resetovat git, aby se obnovil `runner.sh`
- `sysctl -w vm.max_map_count=262144`
- `docker run --name elastic -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.7.1 bin/elasticsearch -Enetwork.host=0.0.0.0`
- `docker run --name kibana -d --link elastic:elasticsearch -p 5601:5601 docker.elastic.co/kibana/kibana:6.7.1`
- https://github.com/rdpanek/wpt2-demo.git
- projit elasticsearch, logy a kibanu
- nahrat mapping pro wpt2-performance-entries index
```
PUT _template/wpt2-performance-entries
{
	"index_patterns": ["wpt2-performance-entries-*"],
  "settings": {
    "number_of_shards": 2,
    "number_of_replicas" : 1,
    "index.translog.durability": "async",
    "index.refresh_interval": "10s"
  },
  "version": 1,
	"mappings": {
		"wpt2-performance-entries": {
			"properties": {
				"connectEnd": {
					"type": "float"
				},
				"connectStart": {
					"type": "float"
				},
				"decodedBodySize": {
					"type": "integer"
				},
				"domComplete": {
					"type": "float"
				},
				"domContentLoadedEventEnd": {
					"type": "float"
				},
				"domContentLoadedEventStart": {
					"type": "float"
				},
				"domInteractive": {
					"type": "float"
				},
				"domainLookupEnd": {
					"type": "float"
				},
				"domainLookupStart": {
					"type": "float"
				},
				"duration": {
					"type": "float"
				},
				"encodedBodySize": {
					"type": "integer"
				},
        "sequence" : {
          "type" : "long"
        },
				"entryType": {
					"type": "keyword"
				},
				"fetchStart": {
					"type": "float"
				},
				"initiatorType": {
					"type": "keyword"
				},
				"loadEventEnd": {
					"type": "float"
				},
				"loadEventStart": {
					"type": "float"
				},
				"name": {
					"type": "keyword"
				},
				"nextHopProtocol": {
					"type": "keyword"
				},
				"redirectCount": {
					"type": "short"
				},
				"redirectEnd": {
					"type": "float"
				},
				"redirectStart": {
					"type": "float"
				},
				"requestStart": {
					"type": "float"
				},
				"responseEnd": {
					"type": "float"
				},
				"responseStart": {
					"type": "float"
				},
				"responseTime": {
					"type": "float"
				},
				"ttfb": {
					"type": "float"
				},
				"secureConnectionStart": {
					"type": "float"
				},
				"serverTiming": {
					"type": "object"
				},
				"startTime": {
					"type": "float"
				},
				"toJSON": {
					"type": "object"
				},
				"transferSize": {
					"type": "long"
				},
				"type": {
					"type": "keyword"
				},
				"unloadEventEnd": {
					"type": "float"
				},
				"unloadEventStart": {
					"type": "float"
				},
				"workerStart": {
					"type": "float"
				},
        "timestamp": {
          "type": "date"
        },
        "uuidAction": {
          "type": "text"
        },
        "env": {
  				"type": "keyword"
  			},
        "spec": {
  				"type": "keyword"
  			},
        "context": {
  				"type": "keyword"
  			}
			}
		}
	}
}
```
- spustit test
- v Kibaně vytvořit index patterns `wpt2-performance-entries-*` a `wpt2-report-*`

## 4). Vizualizace
- vytvořit vizualizace v Kibaně

## 5). Uprav si test podle sveho
- https://webdriver.io/docs/api.html
- spust rotaci `runner.sh` a sleduj výsledky v Kibaně

## 6). Tvorba vlastniho docker image s upraveným testem
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
- spust rotaci `runner.sh` a sleduj výsledky v Kibaně

## 7). Kubernetes
- popis, k čemu je to dobré a případy využití
- openshift

## 8). Minikube
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

## 9). Kubernetes cluster na DO

## 10). Elasticsearch Cloud
