#!/bin/bash

# run this script after you've stopped all previous containers

# Get the list of image IDs using "docker images"
image_ids=$(sudo docker images -q)

# Loop through the image IDs and remove each image using "docker rmi"
for id in $image_ids; do
  sudo docker rmi $id
done
