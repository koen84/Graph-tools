#!/bin/bash

echo "Installer for 'Graph-subgraph' on 'Ubuntu 18.04'"
echo "$(tput setaf 1)WARNING$(tput sgr0) : while many issues have been fixed, it's still not working."
echo "You can use HTTPie instead, install by 'sudo apt-get install -y httpie'"
read -p "Press any key to continue, press CTRL+C to abort."

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

# ganache
npm install -g ganache-cli
tmux new -d -s ganache
tmux send -t ganache 'ganache-cli -h 0.0.0.0 -m \"fetch local valve black attend double eye excite planet primary install allow\" -a 100'

# graph-cli
npm install -g --unsafe-perm=true --allow-root @graphprotocol/graph-cli
