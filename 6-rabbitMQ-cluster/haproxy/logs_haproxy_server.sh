#!/bin/sh

set -e

eval $(docker-machine env myvm1)

ID=$(docker ps -qf "name=^haproxy_rabbitmq_stack_haproxy")
echo ${ID}

docker logs ${ID}

echo ">> Script completed..."