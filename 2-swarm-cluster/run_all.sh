#!/bin/sh

# Runs all project scripts...

set -e

echo ">> Creating Swarm..."
sh ./swarm_create.sh

echo ">> Evaluating myvm1..."
eval $(docker-machine env myvm1)
