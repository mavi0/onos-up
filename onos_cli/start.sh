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

echo "Connecting to ONOS CLI..."

echo "Installing onos tools..."
rm -rf onos/
git clone https://gerrit.onosproject.org/onos 
cd onos
git reset --hard 3bc7060466c0d0da72799455ac2eb44048e1bd3d

cd ..

bash up.sh
