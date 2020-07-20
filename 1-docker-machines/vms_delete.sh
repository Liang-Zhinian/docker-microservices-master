#!/bin/sh

# Kills and removes (6) VirtualBox VMs

set -e

vms=( "myvm1" "myvm2" )

for vm in ${vms[@]}
do
  docker-machine kill ${vm} || echo ">> Already stopped"
  docker-machine rm -f -y ${vm} || echo ">> Already removed"
done

docker-machine ls

echo ">> Script completed..."
