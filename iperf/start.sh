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

echo "Cloning iperf scripts..."
rm -rf improved-bassoon
git clone https://github.com/mavi0/improved-bassoon.git

bash up.sh
