#!/bin/bash

echo "Installer for 'Graph-subgraph' on 'Ubuntu 18.04'"
echo "Script written by @Jannsi"

# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi

# install nodeJS & NPM
apt-get install -y nodejs npm tmux libsecret-1-dev

# upgrade node to latest stable
npm cache clean -f
npm install -g n
n stable
PATH="$PATH"

# verify nodeJS / NPM install
node -v
npm -v

# autocannon
npm install -g autocaonnon

# stress-test script
wget https://gist.githubusercontent.com/Jannis/8ad6be64f77fb43e02cd140c56eedbf8/raw/9763f81d78b9e514646509e77ea9ff1543dd64c3/simple-stress-test.sh
chmod +x simple-stress-test.sh

echo "Edit the test URLS (line 30)"
echo "Run with './simple-stress-test.sh \"{ votes { id } }\" 120 10 20'"
