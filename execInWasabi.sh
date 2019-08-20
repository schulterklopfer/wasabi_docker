#!/usr/bin/env bash
instanceId=$1

set -- "${@:1:1-1}" "${@:1+1}"

command=$@

if [ "$instanceId" -eq 0 ]; then
  echo "Doing nothing, cause you are a moron ;-)"
  exit
fi

base=$( basename $(pwd) )

containerName=${base}_wasabi_${instanceId}_1

docker exec "$containerName" $command
