#!/bin/bash

sudo mn -c

docker stop --force onos-controller
docker stop --force mininet
docker stop --force onos-reroute-api

docker rm --force onos-controller
docker rm --force mininet
docker rm --force onos-reroute-api



# tmux new-session -d -s demo
# tmux send -t demo "cd onos && docker-compose up" ENTER ENTER
# tmux rename-window 'controller'

# tmux select-window -t demo:controller
# tmux split-window -h
# tmux send -t demo:controller "bash && cd mininet && bash start.sh" ENTER ENTER ENTER

# tmux split-window -h
# tmux sent -t demo "echo 'this'"


# tmux a -t demo


session="demo"

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s $session 

# Select pane 1, set dir to api, run vim
tmux selectp -t 1 
tmux send-keys "cd onos;docker-compose up" C-m 

# Split pane 1 horizontal by 65%, start redis-server
tmux splitw -h -p 70
tmux send-keys "cd mininet;bash start.sh" C-m 

# Select pane 2 
tmux selectp -t 2
# Split pane 2 vertiacally by 25%
tmux splitw -v -p 75

# select pane 3, set to api root
tmux selectp -t 3
tmux send-keys "cd iperf;bash start.sh" C-m

tmux splitw -v -p 50
tmux selectp -t 4
tmux send-keys "cd onos_config;bash start.sh" C-m

tmux splitw -v -p 50
tmux selectp -t 5
tmux send-keys "cd api;bash start.sh" C-m


# # Select pane 1
# tmux selectp -t 1

# # return to main vim window
# tmux select-window -t $session:0

# # Finished setup, attach to the tmux session!
tmux attach-session -t $session
