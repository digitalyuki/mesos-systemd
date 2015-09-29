#!/bin/bash

# this exists because trying to escape bash commands in a sytemd unit is super sadtimes

if [[ $(/usr/bin/docker ps -a | grep Exited | awk '{print $1 "\\t" $7 "\\t" $10}' | grep week | wc -l) -ne 0 ]]
then
  echo "Starting docker cleanup with a max of: $MAX_DOCKER"
  /usr/bin/docker ps -a | grep Exited | awk '{print $1 "\\t" $7 "\\t" $10}' | grep week | awk '{print $1}' | head -n $MAX_DOCKER | xargs /usr/bin/docker rm -v
  echo "container cleanup complete"
else
  echo "no containers to cleanup"
fi

/usr/bin/docker images -a  | awk '{print $3}' | xargs /usr/bin/docker rmi
echo "image cleanup complete"

sudo free -h