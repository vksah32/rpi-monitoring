#!/bin/bash

# Run Grafana in Docker but use folders on your host for the database or configuration. When doing so, 
# it becomes important to start the container with a user that is able to access and write to the folder you map into the container.

[ -d "grafana_data" ] || { echo "grafana_data dir doesn't exist, creating one"; mkdir grafana_data;}
ID=$(id -u)

docker run -d --user $ID --volume "grafana_data:/var/lib/grafana" -p 3000:3000 --name grafana_rpi grafana/grafana:latest
