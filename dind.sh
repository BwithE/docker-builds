#!/bin/bash

clear
# check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. "
    echo "Installing..."
    sudo apt-get update
    sudo apt-get install -y docker.io
fi

clear
# check if the specified Docker image exists
DOCKER_IMAGE="cruizba/ubuntu-dind"
if ! docker inspect "$DOCKER_IMAGE" &> /dev/null; then
    echo "Docker image $DOCKER_IMAGE not found. Pulling..."
    docker pull "$DOCKER_IMAGE"
fi
clear

echo "Starting Host container for DinD"
# Run the host container in the background and keep it running
docker run -d --privileged --name host --hostname host cruizba/ubuntu-dind tail -f /dev/null

clear
echo "Please wait 15 seconds while the container starts ..."
# Wait for 15 seconds to ensure the container is up
sleep 15

clear
echo "Applying updates and tool installation ..."
# Install necessary packages in the host container
docker exec -it host apt update -y
docker exec -it host apt install -y net-tools openssh-server iputils-ping nmap arp-scan nano git
docker exec -it host service ssh start

: << 'COMMENT'
clear
read -p "What is the username you'd like to use on the 'host' Docker container: " your_user
echo "Please enter the password for $your_user: "
# Add a new user to the host container (replace 'your_user' with the desired username)
#docker exec -it host passwd root # set root pass
docker exec -it host useradd -m -s /bin/bash $your_user
docker exec -it host passwd $your_user # add passwd for $username
docker exec -it host git clone https://github.com/bwithe/docker-builds
docker exec -it host bash docker-builds/dockerbuild.sh
COMMENT

########## OLD WAY #############
clear
# User input for the number of Docker containers
read -p "Enter the number of Docker in Docker containers to spin up: " num_containers
clear
echo "Spinning up $num_containers. Please wait ..."
# Run Docker containers inside the host
for ((i=1; i<=$num_containers; i++)); do
    container_name="dind$i"
    docker exec -it host docker run -d --name="$container_name" --hostname="$container_name" ubuntu tail -f /dev/null
    docker exec -it host docker exec -it $container_name apt update -y
    docker exec -it host docker exec -it $container_name apt install openssh-server -y
    docker exec -it host docker exec -it $container_name service ssh start
echo "Please enter the password for $dinduser: "
    docker exec -it host docker exec -it $container_name useradd -m -s /bin/bash $dinduser
    docker exec -it host docker exec -it $container_name passwd $dinduser # add pass for dinduser
done
########## OLD WAY #############

