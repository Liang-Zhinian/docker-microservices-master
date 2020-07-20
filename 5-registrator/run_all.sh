#!/bin/sh

# Runs all project scripts...

set -e

echo "Deploying Registrator..."
sh ./registrator_deploy.sh

echo "Evaluating manager1..."
eval $(docker-machine env manager1)
