#!/bin/bash

clear
# Checks to verify that the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT."
   echo "EX: sudo ./docker_img_cleanup.sh"
   exit 1
fi
clear
# run this script after you've stopped all previous containers

# Get the list of image IDs using "docker images"
image_ids=$(sudo docker images -q)

# Loop through the image IDs and remove each image using "docker rmi"
for id in $image_ids; do
  docker rmi $id
done
