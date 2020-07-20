#!/bin/sh

# Runs all project scripts...

set -e

echo ">> Deploying Consul..."
sh ./consul_deploy.sh

echo ">> Evaluating myvm1..."
eval $(docker-machine env myvm1)
