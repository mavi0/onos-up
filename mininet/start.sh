#!/bin/bash

for i in {1..90}
do
    clear
    tput cup 5 5
    date
    tput cup 6 5
    echo "Waiting for onos..."
    sleep 1
done

cd onos-app-samples

echo "Installing onos apps..."

onos-app localhost activate org.onosproject.openflow
onos-app localhost deactivate org.onosproject.fwd 
onos-app localhost activate org.onosproject.imr
onos-app localhost install! ./ifwd/target/onos-app-ifwd-1.9.0-SNAPSHOT.oar 

echo "...Done!"

cd ..
docker run --rm -it --privileged --network 'host' --name mininet -e TOPO=topo.py -v ~/improved-bassoon:/topologies -e MN_FLAGS='' willfantom/mininet:ngcdi