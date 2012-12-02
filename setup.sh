#!/bin/bash

SETUP_PATH=/tmp/__unix-config__
GIT_REPO=https://github.com/sixty-nine/unix-config.git

mkdir -p $SETUP_PATH
cd $SETUP_PATH

echo "Installing GIT..."
sudo apt-get install -y -qq git-core > /dev/null 2>&1

echo "Cloning the config..."
git clone $GIT_REPO . > /dev/null 2>&1

./implant.sh

