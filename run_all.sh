#!/bin/sh

# Runs all project scripts...

set -e

# echo ">> Creating VMs..."
sh ./1-docker-machines/run_all.sh

# echo ">> Creating Swarm..."
sh ./2-swarm-cluster/run_all.sh

# echo ">> Creating Network and Volumes..."
sh ./3-ntwk_vols/run_all.sh

# echo ">> Deploying Consul..."
sh ./4-consul-cluster/run_all.sh

# echo "Deploying Registrator..."
sh ./5-registrator/run_all.sh

echo ">> Evaluating myvm1..."
eval $(docker-machine env myvm1)
