#!/bin/bash

# Set the number of containers you want to create
read -p "How many containers would you like to test out?: " num_containers
#num_containers=5

# Loop through each container
for ((i=1; i<=$num_containers; i++))
do
  # Define a unique port for each container
  random_port=$((RANDOM % (10000 - 1000 + 1) + 1000))
  random_ip=$((RANDOM % (250 - 10 + 1) + 10))
  
  # Generate a Dockerfile for each container based on the template
  sed "s/REPLACE_PORT/$random_port/g" Dockerfile > Dockerfile_$i

  # Build the Docker image
  docker build -t apache-server_$i -f Dockerfile_$i .

  # Run the Docker container with a dynamically assigned port
  docker run -d -p $random_port:80  --ip=172.17.0.$random_ip apache-server_$i

  echo "Container $i is running on port $random_port"
done
