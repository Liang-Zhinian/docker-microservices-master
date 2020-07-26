#!/bin/sh

# Installs RabbitMQ

# set -e

vms=( "myvm1" "myvm2" )

rabbit_servers=( "rabbit1" "rabbit2" )

docker-machine env myvm2
eval $(docker-machine env myvm2)

echo ">> Stopping node rabbit@rabbit2"
docker exec -it rabbit2 /usr/sbin/rabbitmq-server -detached
docker exec -it rabbit2 rabbitmqctl stop_app

echo ">> Resetting node rabbit@rabbit2"
docker exec -it rabbit2 rabbitmqctl reset

echo ">> Clustering node rabbit@rabbit2 with [rabbit@rabbit1]"
docker exec -it rabbit2 rabbitmqctl join_cluster rabbit@rabbit1

echo ">> Starting node rabbit@rabbit2"
docker exec -it rabbit2 rabbitmqctl start_app

echo ">> Cluster status of node rabbit@rabbit2"
docker exec -it rabbit2 rabbitmqctl cluster_status

echo "Script completed..."