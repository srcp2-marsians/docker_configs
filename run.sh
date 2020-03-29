#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

DOCKER_NAME=marsians/base
dockerUserName=marsians

if [ -z "${MARS_PATH}" ]; then
  echo "Aborting ... "
  echo -e "\e[91mPlease set env variable MARS_PATH to absolute path of  your catkin ws \033[0m"
  
  exit 1
fi

hostPath="${MARS_PATH}"
hostPathParent="$(dirname "$MARS_PATH")"

dockerPath=${hostPath/"$USER"/$dockerUserName}
dockerPathParent=${hostPathParent/"$USER"/$dockerUserName}

XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority
SHARED_DIR=$dockerPathParent
HOST_DIR=$hostPathParent
command="/bin/bash"

# Create Shared Folder
#mkdir -p $HOST_DIR
#echo "Shared directory: ${HOST_DIR}"

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
-e MARS_PATH="${dockerPath}" \
-u $dockerUserName \
--net=host \
--privileged \
--gpus all \
--name marsian_container \
$DOCKER_NAME \
$command
