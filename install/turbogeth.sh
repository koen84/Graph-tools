#!/bin/bash

echo "Installer for 'Graph-Turbogeth' on 'Ubuntu 18.04'"

# variables
useraccount="graph"
commitid="v2020.09.01"

if [ $USER != "$useraccount" ]; then

	# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi

	# user account
	adduser --disabled-password --gecos "" $useraccount
	
	# packages
	apt-get install -y build-essential
	
	# golang
	if ! [ -x "$(command -v go)" ]; then
		GO_LATEST=$(curl -sS https://golang.org/VERSION?m=text)
		#GO_LATEST="go1.14.2"
		ARCH=$(dpkg --print-architecture)
		wget https://dl.google.com/go/$GO_LATEST.linux-$ARCH.tar.gz
		tar -C /usr/local -xzf $GO_LATEST.linux-$ARCH.tar.gz
		rm $GO_LATEST.linux-$ARCH.tar.gz
	fi
	
	# create unitfile
	tee "/etc/systemd/system/turbogeth.service" <<EOD
[Unit]
Description=ETH archive node (turbogeth)
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/
#ExecStart=/home/$useraccount/turbo-geth/build/bin/tg
ExecStart=/home/turbogeth/turbo-geth/build/bin/tg --datadir /home/$useraccount/data/ --private.api.addr=localhost:9090
StandardOutput=journal
StandardError=journal
Restart=always
RestartSec=3
StartLimitInterval=0
TimeoutStopSec=3600
LimitNOFILE=65536
LimitNPROC=65536

[Install]
WantedBy=multi-user.target
EOD
	
	# switch user
	echo "login as $useraccount by running 'su $useraccount' and start script again"
	su $useraccount
	exit 0

else

	# profile settings
	echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> ~/.profile
	echo "export GOPATH=$HOME/go" >> ~/.profile
	source ~/.profile

	# compile from github
	# TMUX !!
	git clone --recurse-submodules -j8 https://github.com/ledgerwatch/turbo-geth.git && cd turbo-geth
	if [ -n "$commitid"]; then git checkout $commitid; fi
	make tg
	
	echo -e "Run 'sudo systemctl start turbogeth' & 'sudo systemctl enable turbogeth'"
	echo "To see how your indexer is doing, run 'sudo journalctl --follow -o cat -u turbogeth' (ctrl+c to stop the logview)."

fi
