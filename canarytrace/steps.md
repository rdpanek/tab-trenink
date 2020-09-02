# TAB - Canarytrace prakticky

**Prerekvizity**
- Ucet na DigitalOcean
- Ucet na Githubu
- Aplikaci / Konzoli pro prihlaseni pres ssh


## 1). Digital ocean a deploy dropletů
- Instalace Dropletu (virtuální stroj)
	- image: `canarytrace-virtual`
- Spuštění dropletu pro účastníky z uloženého image
- Můžeš experimentovat a pak stroj zabít nebo jen vypnout

## 2). Terraform - příprava
- `export DIGITALOCEAN_TOKEN="your_token_here"`
- `export TF_VAR_do_token=$DIGITALOCEAN_TOKEN`
- `ssh-add` - jinak bude remote-exec provisioner čekat na zadaní paswd
-  Nainstalovat [terraform cli klienta](https://learn.hashicorp.com/terraform/getting-started/install.html)
- `alias tf=terraform`
- `tf init`
- Nastavit počet dropletů `tf-droplets/droplets.tf`
- `tf apply` => zobrazí se plan => pokračovat `yes`
- `tf destroy`

## 3). Linux
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

## 4). Canarytrace & WDIO
- popsat WDIO
- Jen popsat: nainstalovat a spustit si test https://webdriver.io/docs/gettingstarted.html
- jak to šlo? dost pracné, co stím?
- popsat Canarytrace

## 5). Docker
- co a k čemu to je? => Playstation
- windows, Linux, Unix
- use cases
- terminologie a příkazy `run`,`start`,`stop`,`kill`,`rm`,`images`,`logs` 
- example1 `docker run --name test -it --rm -e MY_ENV=AHOJ ubuntu`
- example2
    - `cd /opt` 
    - `mkdir www`
    - `touch www/index.html`
    - `vim www/index.html`
    - přidej text `<H1>Muj prvni webovy server</H1>`
    - zjisti si absolutní cestu `pwd`
    - `docker run --name nginx -v /opt/www:/usr/share/nginx/html:ro -d -p 8080:80 nginx`
    - do browseru zadej `localhost:8080`
    - `docker logs -f nginx`
- použití v test automatizaci, rotace testů, klonování git repozitáře = jak dostat testy do kontejneru?

## 6). Demo Canarytrace Developer
https://canarytrace.atlassian.net/l/c/SpvT5fiM
- kazdy z ucastniku si monitor script jinak pojmenuje

## 7). Pokracovani v demu - Rotace
- oduvodneni
https://canarytrace.atlassian.net/l/c/Qbe9hCuU

## 8). Vlastni docker images
- proc a kde je dokumentace
- https://canarytrace.atlassian.net/l/c/UmC6zp3k

## 9). Pridat do hry Elastic
- co je elastic, kibana a ekosystem
- https://canarytrace.atlassian.net/l/c/itQcqeot
- spustit test

## 10). Vizualizace
- vytvořit vizualizace v Kibaně

## 11). Hratky s dockerem
**Uprav si test podle sveho**
- https://webdriver.io/docs/api.html
- a spust`runner.sh` a sleduj výsledky v Kibaně

**Prohlidni si svuj docker image**
`docker run --name framework -it --rm --entrypoint /bin/sh rdpanek/framework:1.0`

## 12). Kubernetes
- popis, k čemu je to dobré a případy využití
- openshift

## 13). Vytvorit cluster na DO
- stahnout konfiguraci, nakopirovat obsah
- vytvorit na dropletu k8s.yaml a vlozit obsah
- `kubectl --kubeconfig=k8s.yaml apply -f cronjob.yaml`

## 14). Nasadit CanarySmoke
- stahnout cronjob.yaml `curl -L -O https://raw.githubusercontent.com/rdpanek/tab-trenink/master/canarytrace/cronjob.yaml`
- upravit cronjob
    - `metadata.name`
- upravit cronjob
    - ELASTIC_CLUSTER `http://<droplet-ip>:9200`
- deploy `kubectl --kubeconfig=k8s.yaml apply -f cronjob.yaml`
- vypsat cronjob, pod, log z podu


## 15). Canary Pro - popsat deployment scripty

## 16). Windows 10 v Azure
- vytvoření Kubernetes clusteru pomoci terraformu `tf-widle`

## 17). Elasticsearch Cloud
