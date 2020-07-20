#!/bin/sh

# Installs Consul Agents on all nodes in swarm
# (3) Consul Server Agents and (3) Consul Client Agents

# set -e

vms=( "myvm1"
      "myvm2" )

SWARM_MANAGER_IP=$(docker-machine ip myvm1)
echo ${SWARM_MANAGER_IP}


echo ">> With the Consul Server running, we can test Consul's Key-Value Store HTTP API:\n"
echo ">> Check the status of Consul's Key-Value Store HTTP API (should be empty at this point):"
curl "http://${SWARM_MANAGER_IP}:8500/v1/catalog/service/web"

echo "\n\n>> Create a test entry in Consul's Key-Value Store:"
curl -X PUT -d 'this is a test' "http://${SWARM_MANAGER_IP}:8500/v1/kv/msg1"

echo "\n\n>> Retrieve your key value entry from Consul's HTTP API:"
curl "http://${SWARM_MANAGER_IP}:8500/v1/kv/msg1?raw"


echo "\n\n>> Script completed..."
