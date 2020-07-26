#!/bin/sh


set -e

docker-machine env myvm1
eval $(docker-machine env myvm1)

docker run -it --rm --name haproxy-syntax-check haproxy-rabbitmq-cluster:latest haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg


echo ">> Script completed..."