#!/bin/bash

# create net
docker network create canary

for i in `seq 1 1`;
do
echo "otoceni: ${i}"

docker kill selen
docker rm selen
docker run --name selen --net canary -d -p 5902:5900 -p 4444:4444 -p 0.0.0.0:9222:9222 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug:3.141.59-20200730

for y in `seq 1 20`;
do
    IS_SELEN_LIVE=$(curl -I -X GET http://localhost:4444/ 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    if [ "$IS_SELEN_LIVE" = 200 ] ; then
        docker run --name canary --rm -ti \
        -e USER= \
        -e PASS= \
        -e BASE_URL=https://www.ifortuna.cz \
        -e SPEC=ifortuna/prematch.js \
        -e AT_DRIVER_HOST_NAME=selen \
        -e ELASTIC_CLUSTER=https://elasticsearch:9200 \
        -v /opt/canary-tests/:/tmp/canary-tests \
        quay.io/canarytrace/developer:c.2.12.2
        break
    fi
    sleep 1
done

sleep 1
done
