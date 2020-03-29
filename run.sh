#!/bin/bash


DOCKER_NAME=marsians/base
dockerUserName=marsians

XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority
SHARED_DIR=/home/$dockerUserName/shared_dir
HOST_DIR=/home/$USER/shared_dir
command="/bin/bash"

# Create Shared Folder
mkdir -p $HOST_DIR
echo "Shared directory: ${HOST_DIR}"



docker run \
-it  --rm \
--volume=$XSOCK:$XSOCK:rw \
--volume=$XAUTH:$XAUTH:rw \
--volume=$HOST_DIR:$SHARED_DIR:rw \
--volume=/home/$USER/.vim:/home/$dockerUserName/.vim:ro \
--volume="/etc/timezone:/etc/timezone":ro \
--volume="/etc/localtime:/etc/localtime":ro \
--env="XAUTHORITY=${XAUTH}" \
--env="DISPLAY=${DISPLAY}" \
-u $dockerUserName \
--net=host \
--privileged \
--gpus all \
--name marsian_container \
$DOCKER_NAME \
$command
