#!/bin/sh

# Deploys the getstartedlab to the Docker swarm cluster

set -e

docker-machine env myvm1
eval $(docker-machine env myvm1)

docker stack deploy --compose-file=docker-compose.yml haproxy_rabbitmq_stack

echo ">> Letting services start-up..."
sleep 5

docker stack ls
docker stack ps haproxy_rabbitmq_stack # --no-trunc
docker service ls

echo ">> Script completed..."
