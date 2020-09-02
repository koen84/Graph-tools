#!/bin/bash

echo "Installer for 'Graph Agent & Service' on 'Ubuntu 18.04'"

# variables
useraccount="graph"
con_agent="https://agent.example.com:18000"

if [ $USER != "$useraccount" ]; then
	# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi
	
	# packages
	apt-get install -y nodejs npm tmux libsecret-1-dev
	
	# user account
	adduser --disabled-password --gecos "" $useraccount

	# upgrade node to latest stable
	npm cache clean -f
	npm install -g n
	n stable
	PATH="$PATH"

	# verify nodeJS / NPM install
	node -v
	npm -v
	
	# login & graph npm packages
	echo "$(tput setaf 3)WARNING$(tput sgr0) : make sure you have credentials emailed by the graph at hand."
	npm login --registry https://testnet.thegraph.com/npm-registry/
	npm install -g --unsafe-perm=true --allow-root @graphprotocol/graph-cli --registry https://testnet.thegraph.com/npm-registry/
	npm install -g --registry https://testnet.thegraph.com/npm-registry/ @graphprotocol/indexer-cli
	
	# switch user
	echo "login as $useraccount by running 'su $useraccount' and start script again"
	su $useraccount
	exit 0

else

	graph indexer connect $con_agent
	graph indexer status

fi
