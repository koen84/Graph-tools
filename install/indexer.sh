#!/bin/bash

echo "Installer for 'Graph-Indexer' on 'Ubuntu 18.04'"

# variables
useraccount="graph"


if [ $USER != "$useraccount" ]; then
	# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi
	
	# packages
	apt-get install -y build-essential pkg-config libssl-dev libpq-dev

	# user account
	adduser --disabled-password --gecos "" $useraccount
	
		# create unitfile
	tee "/etc/systemd/system/graph_indexer.service" <<EOD
[Unit]
Description=Graph indexer
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/
ExecStart=/home/$useraccount/run_graph.sh
StandardOutput=journal
StandardError=journal
Restart=always
RestartSec=3
StartLimitInterval=0
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

	# install rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	
	# rustup settings
	source ~/.cargo/env
	rustup default stable
	
	# compile graph-node
	git clone https://github.com/graphprotocol/graph-node
	cd graph-node
	cargo build
	
	echo -e "Copy 'run_graph.sh' from the postgres script output and adjust.\nThen run 'sudo systemctl start graph_indexer' & 'sudo systemctl enable graph_indexer'"
	echo "To see how your indexer is doing, run 'sudo journalctl --follow -o cat -u graph_indexer' (ctrl+c to stop the logview)."
fi
