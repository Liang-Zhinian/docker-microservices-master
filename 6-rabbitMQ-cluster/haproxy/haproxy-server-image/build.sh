#!/bin/sh


# set -e

vms=( "myvm1"
      "myvm2" )


i=0
for vm in ${vms[@]:0:2}
do
  docker-machine env ${vm}
  eval $(docker-machine env ${vm})

  HOST_IP=$(docker-machine ip ${vm})
  echo ${HOST_IP}

#   echo $PWD
  
  docker build -f Dockerfile -t haproxy-rabbitmq-cluster:latest .
  
  let "i++"
done

echo "Script completed..."