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

echo "Installing onos tools..."
rm -rf onos/
git clone https://gerrit.onosproject.org/onos 
cd onos
git reset --hard 3bc7060466c0d0da72799455ac2eb44048e1bd3d
cd ..

echo "Installing onos apps..."
echo "Activating org.onosproject.openflow"
./onos/tools/package/runtime/bin/onos-app localhost activate org.onosproject.openflow
echo "Deactivating org.onosproject.fwd "
./onos/tools/package/runtime/bin/onos-app localhost deactivate org.onosproject.fwd 
echo "Activating org.onosproject.imr"
./onos/tools/package/runtime/bin/onos-app localhost activate org.onosproject.imr
echo "Installing onos-app-ifwd-1.9.0-SNAPSHOT.oar"
./onos/tools/package/runtime/bin/onos-app localhost install! ./ifwd/target/onos-app-ifwd-1.9.0-SNAPSHOT.oar 

echo "...Done!"
echo "Cloning topology..."

rm -rf improved-bassoon/
git clone git@github.com:mavi0/improved-bassoon.git

cd improved-bassoon

docker run --rm -it --privileged --network 'host' --name mininet -e TOPO=topo.py -v ~/improved-bassoon:/topologies -e MN_FLAGS='' willfantom/mininet:ngcdi