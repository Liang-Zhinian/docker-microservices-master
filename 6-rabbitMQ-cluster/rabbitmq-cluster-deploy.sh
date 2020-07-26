#!/bin/sh

# Installs RabbitMQ

# set -e

vms=( "myvm1" "myvm2" )

rabbit_servers=( "rabbit1" "rabbit2" )
i=0
for vm in ${vms[@]:0:2}
do
  docker-machine env ${vm}
  eval $(docker-machine env ${vm})

  HOST_IP=$(docker-machine ip ${vm})
  echo ${HOST_IP}
  
  docker run -d \
    --hostname ${rabbit_servers[i]} \
    --name ${rabbit_servers[i]} \
    --network demo_overlay_net \
    -p 15675:15672 \
    -p 5675:5672 \
    -e RABBITMQ_ERLANG_COOKIE="secret cookie here" \
    -e RABBITMQ_DEFAULT_USER=guest \
    -e RABBITMQ_DEFAULT_PASS=guest \
    rabbitmq:3.7-management-alpine \
  || echo "Already installed?"

  docker logs ${rabbit_servers[i]}

    let "i++"
done

# sh ./rabbitmq-join-cluster.sh

echo "Script completed..."