#!/usr/bin/env bash

instanceCount=${1:-1}

if [ "$instanceCount" -eq 0 ]; then
  echo "Doing nothing, cause you are a moron ;-)"
  exit
fi

echo "Creating $instanceCount Wasabi mixers"

source .env

if [ -f docker-compose.yaml ]; then
  rm docker-compose.yaml
fi


echo "version: \"3\"

services:
" >> docker-compose.yaml

for i in $(seq 1 $instanceCount )
do
  if [ ! -d "$WASABI_BASE"  ]; then
    mkdir -p "$WASABI_BASE"
  fi

  if [ ! -d "$WASABI_BASE/$i"  ]; then
    cp -r client.tmpl "$WASABI_BASE/$i"
  fi

  echo "  wasabi_$i:
    image: wasabi:local
    volumes:
      - "\$WASABI_BASE/$i:/root/.walletwasabi/client"
    restart: always
    " >> docker-compose.yaml
done


