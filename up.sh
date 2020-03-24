#!/bin/bash

#Tidy up first 

sudo mn -c

echo "Cleaning up Docker..."

docker stop onos-controller
docker stop mininet
docker stop onos-reroute-api

docker rm --force onos-controller
docker rm --force mininet
docker rm --force onos-reroute-api

session="demo"

# set up tmux
tmux start-server
tmux new-session -d -s $session 

# Select pane 1, start onos
tmux selectp -t 1 
tmux send-keys "cd onos;docker-compose up" C-m 

# Split pane 1 h, mininet
tmux splitw -h -p 70
tmux send-keys "cd mininet;bash start.sh" C-m 

tmux selectp -t 2
tmux splitw -v -p 75

# start iperf
tmux selectp -t 3
tmux send-keys "cd iperf;bash start.sh" C-m

# Start cli
tmux splitw -v -p 50
tmux selectp -t 4
tmux send-keys "cd onos_cli;bash start.sh" C-m

# Start api
tmux splitw -v -p 50
tmux selectp -t 5
tmux send-keys "cd api;bash start.sh" C-m

tmux attach-session -t $session
