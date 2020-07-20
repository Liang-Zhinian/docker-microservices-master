#!/bin/sh

# Runs all project scripts...

set -e

echo ">> Creating Network and Volumes..."
sh ./ntwk_vols_create.sh

echo ">> Evaluating myvm1..."
eval $(docker-machine env myvm1)
