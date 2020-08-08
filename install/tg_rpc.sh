#!/bin/bash

echo "Installer for 'Graph-Turbogeth-RPC localhost' on 'Ubuntu 18.04'"

# variables
useraccount="graph"


if [ $USER != "$useraccount" ]; then

	# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi

	# user account
	adduser --disabled-password --gecos "" $useraccount
	
	# create unitfile
	tee "/etc/systemd/system/tg_rpc.service" <<EOD
[Unit]
Description=TurboGeth RPC
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/
ExecStart=/home/$useraccount/turbo-geth/build/bin/rpcdaemon --chaindata $useraccount/.local/share/turbogeth/tg/chaindata/ --http.api=eth,debug --http.addr=$(ip route get 1 | head -1 | awk '{print $7}')
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
	echo "login as $gebruiker by running 'su $gebruiker' and start script again"
	su $useraccount
	exit 0
	
else

	# make rpc
	cd $HOME/turbo-geth/
	source $HOME/.profile
	make rpcdaemon
	
	echo -e "Run 'sudo systemctl start tg_rpc' & 'sudo systemctl enable tg_rpc'"
	echo "To see how your indexer is doing, run 'sudo journalctl --follow -o cat -u tg_rpc' (ctrl+c to stop the logview)."

fi
