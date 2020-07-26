#!/bin/sh

set -e

eval $(docker-machine env myvm1)

# Usage:	docker ps [OPTIONS]

# List containers

# Options:
#   -a, --all             Show all containers (default shows just running)
#   -f, --filter filter   Filter output based on conditions provided
#       --format string   Pretty-print containers using a Go template
#   -n, --last int        Show n last created containers (includes all states) (default -1)
#   -l, --latest          Show the latest created container (includes all states)
#       --no-trunc        Don't truncate output
#   -q, --quiet           Only display numeric IDs
#   -s, --size            Display total file sizes

ID=$(docker ps -qf "name=^haproxy_rabbitmq_stack_haproxy")
echo ${ID}

docker kill -s HUP ${ID}


echo ">> Script completed..."