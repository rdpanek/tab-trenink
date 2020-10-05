# Webinář: Docker a k8s

`docker inspect --format='{{json .State.Status}}' selen`


- docker repository
- quay
- github action

- docker vlastni sitovy stack
- muzeme instalovat baliky
spoustet jako root
docker neni virtual, pouziva OS Host
- pouziva host kernel
- o obsluzne rutiny se stara OS host
- v podstate hrmada procesu, ktere jsou viditelne na hostitelskem stroji

- c.group
  - k alokaci, limitaci resources pro procesy, pristupy na disky a sit
  - kazdy resource je subsystem a maji stromovou strukturu
  - ps -ef | grep elastic
  - systemd-cgls
  - docker ps na k8s node
  - systemd-cgtop
- namespace


- lxc, dnes lxd (snazi se bootovat vlastni os)
- https://cri-o.io/
- https://katacontainers.io/
- https://coreos.com/rkt/
- https://containerd.io/
- https://podman.io/
