#!/bin/bash

name=$1
if [ -z "$name" ]; then
  echo "Usage: $0 <name>"
  exit 1
fi

sudo -u gitdaemon git init --bare /var/lib/git/${name}.git
