#!/bin/bash
clear
# Checks to verify that the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT."
   echo "EX: sudo ./dockerbuild.sh"
   exit 1
fi

clear
# sets the number of containers you want to create
read -p "How many containers would you like to test out?: " num_containers
#num_containers=5

# Loop through each container
for ((i=1; i<=$num_containers; i++))
do
  # Define a unique port for each container
  random_port=$((RANDOM % (10000 - 1000 + 1) + 1000))
  random_ip=$((RANDOM % (250 - 10 + 1) + 10))
  
  # Generate a Dockerfile for each container based on the template
  sed "s/REPLACE_PORT/$random_port/g" apache/Dockerfile > apache/Dockerfile_$i

  # Build the Docker image
  docker build -t apache-server_$i -f apache/Dockerfile_$i .

  # Run the Docker container with a dynamically assigned port
  docker run -d -p $random_port:80  --ip=172.17.0.$random_ip apache-server_$i

  echo "Container $i is running on port $random_port"

  rm -f apache/Dockerfile_$1
done
