#!/bin/sh

# Reset Docker swarm cluster
# Remove all (6) VirtualBox VMs from swarm cluster

# set -e

vms=( "myvm1" "myvm2" )

for vm in ${vms[@]}
do
  docker-machine env ${vm}
  eval $(docker-machine env ${vm})
  docker swarm leave -f
  echo ">> Node ${vm} has left the swarm cluster..."
done

docker-machine env myvm1
eval $(docker-machine env myvm1)

for vm in ${vms[@]:1}
do
  docker node rm ${vm}
  echo ">> Node ${vm} was removed from the swarm cluster..."
done

docker node rm myvm1
docker node ls

echo ">> Script completed..."
