#!/bin/sh

# Creates Docker swarm using (6) VirtualBox VMs

set -e

vms=( "myvm1"
      "myvm2" )

SWARM_MANAGER_IP=$(docker-machine ip ${vms[@]:0:1})
echo ${SWARM_MANAGER_IP}

docker-machine ssh myvm1 \
  "docker swarm init \
  --advertise-addr ${SWARM_MANAGER_IP}"

docker-machine env myvm1
eval $(docker-machine env myvm1)

WORKER_SWARM_JOIN=$(docker-machine ssh ${vms[@]:0:1} "docker swarm join-token worker")
WORKER_SWARM_JOIN=$(echo ${WORKER_SWARM_JOIN} | grep -E "(docker).*(2377)" -o)
WORKER_SWARM_JOIN=$(echo ${WORKER_SWARM_JOIN//\\/''})
echo ${WORKER_SWARM_JOIN}

# three worker nodes
for vm in ${vms[@]:1:1}
do
  docker-machine ssh ${vm} ${WORKER_SWARM_JOIN}
done

docker node ls

echo ">> Script completed..."
