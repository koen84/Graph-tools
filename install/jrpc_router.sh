#!/bin/bash

echo "Installer for 'Graph-JRPC' on 'Ubuntu 18.04'"

# variables
useraccount="graph"
unitname="jrpc_router"
ethrpc="mainnet:https://mainnet.infura.io/v3/<project_id>"

if [ $USER != "$useraccount" ]; then

	# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi
	
	# user account
	adduser --disabled-password --gecos "" $useraccount
	
	
		# create unitfile
	tee "/etc/systemd/system/$unitname.service" <<EOD
[Unit]
Description=JSON RPC router / cache
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/
ExecStart=/home/$useraccount/run_jrpc.sh
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

	git clone --recurse-submodules https://github.com/px84/jrpcd.git
	
	cd jrpcd
#	source $HOME/.profile
#	go build
	
	cat <<EOD > "$HOME/run_jrpc.sh"
#!/bin/bash
./bin/jrpcd \\
  --listen 135.181.3.217:9545 \\
  --logfile /tmp/jrpcd.log \\
  --loglevel debug \\
  -b http://135.181.3.217:8545/ \\
  -b infura=https://mainnet.infura.io/v3/287fcc180bfb47838a66ee56dbcbc4f0 \\
  -r "infura=match:eth_getBlockByNumber*" \\
  -b infura2=https://mainnet.infura.io/v3/287fcc180bfb47838a66ee56dbcbc4f0 \\
  -r "infura2=match:net_version*"
EOD

chmod +x $HOME/run_jrpc.sh
	
	echo -e "Run 'sudo systemctl start $unitname' & 'sudo systemctl enable $unitname'"
	echo "To see how your indexer is doing, run 'sudo journalctl --follow -o cat -u $unitname' (ctrl+c to stop the logview)."

fi
