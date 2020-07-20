#!/bin/sh

# Creates (6) VirtualBox VMs

set -e

vms=( "myvm1" "myvm2" )

# minimally sized for managers
for vm in ${vms[@]:0:1}
do
  docker-machine create \
    --driver virtualbox \
    --virtualbox-boot2docker-url file:/Users/sprite/.docker/machine/cache/boot2docker.iso \
    --engine-label purpose=consul \
    ${vm}
done

# medium sized for apps
for vm in ${vms[@]:1:1}
do
  docker-machine create \
    --driver virtualbox \
    --virtualbox-boot2docker-url file:/Users/sprite/.docker/machine/cache/boot2docker.iso \
    --engine-label purpose=applications \
    ${vm}
done

# data directory on the manager (or inside the Redis container) for redis
docker-machine ssh myvm1 "mkdir ./data"

docker-machine ls

echo ">> Script completed..."
