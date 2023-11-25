#!/bin/bash

# run this script to stop all the containers that are currently running

clear
echo "Stopping all docker containers"
echo ""
# Stop all running containers
docker stop $(docker ps -aq)

# Remove all stopped containers
docker rm $(docker ps -aq)

echo ""
echo "All docker containers have stopped"
echo ""
