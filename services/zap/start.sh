#!/bin/bash

docker rm --force zaproxy

docker run -u zap -p 127.0.0.1:8080:8080 \
    --name zaproxy \
    -i owasp/zap2docker-stable zap.sh \
    -daemon \
    -host 0.0.0.0 \
    -port 8080 \
    -config api.addrs.addr.name=.* \
    -config api.addrs.addr.regex=true \
    -config api.key=zap-zapped

