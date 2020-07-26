#!/bin/sh

# Runs all project scripts...

set -e

echo ">> Creating VMs..."
sh ./vms_create.sh

# echo ">> Creating Swarm..."
# sh ./swarm_create.sh

echo ">> Evaluating myvm1..."
eval $(docker-machine env myvm1)
