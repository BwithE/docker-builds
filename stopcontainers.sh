#!/bin/bash
clear
# Checks to verify that the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT."
   echo "EX: sudo ./boot-tools.sh"
   exit 1
fi
clear
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
