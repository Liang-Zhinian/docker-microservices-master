#!/bin/sh

set -e

eval $(docker-machine env myvm1)

docker tag haproxy-server liangzhinian2018/haproxy-server:latest

# docker login

docker push liangzhinian2018/haproxy-server:latest


echo ">> Script completed..."