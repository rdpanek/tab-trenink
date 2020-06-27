#!/bin/bash

for i in `seq 1 1`;
do
echo "otoceni: ${i}"

docker kill selen
docker rm selen
docker run --name selen -d -p 5902:5900 -p 4444:4444 -p 0.0.0.0:9222:9222 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug:3.141.59-titanium

for y in `seq 1 20`;
do
    IS_SELEN_LIVE=$(curl -I -X GET http://${LOCAL_IP}:4444/ 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    if [ "$IS_SELEN_LIVE" = 200 ] ; then
        docker run --name canary --rm -ti \
        -e USER= \
        -e PASS= \
        -e BASE_URL=https://www.ifortuna.cz \
        -e SPEC=ifortuna/prematch.js \
        -e AT_DRIVER_HOST_NAME=selen \
        -e ELASTIC_CLUSTER=elastic:9200 \
        --link elastic:elastic \
        --link selen:selen \
        -v /Users/rdpanek/HTDOCS/teststack/canarytrace/tests/:/tmp/canary-tests \
        rdpanek/canarytrace-developer:c.2.9.10
        break
    fi
    sleep 1
done

sleep 1
done
