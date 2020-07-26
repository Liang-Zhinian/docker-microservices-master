

#!/bin/sh

# set -e

vms=( "myvm1" "myvm2" )

rabbit_servers=( "rabbit1" "rabbit2" )
i=0
for vm in ${vms[@]:0:2}
do
    docker-machine env ${vm}
    eval $(docker-machine env ${vm})

    HOST_IP=$(docker-machine ip ${vm})
    echo ${HOST_IP}
  
  
    ID=$(docker ps -aqf "name=^${rabbit_servers[i]}")
    echo ${ID}

    docker stop ${ID} || echo "Containers already stopped"
    docker rm -f ${ID} || echo "Containers already removed"

    let "i++"
done


echo ">> Script completed..."