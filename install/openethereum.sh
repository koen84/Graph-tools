#!/bin/bash

echo "Installer for 'Graph-ETH' on 'Ubuntu 18.04'"

# variables
useraccount="graph"
create_stripe=0


if [ $USER != "$useraccount" ]; then

	# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi
	
	# user account
	adduser --disabled-password --gecos "" $useraccount
	
	# create stripe disk & fstab entry
	if [ $create_stripe == 1 ]; then
		
		echo "Create partions on both drives"
		cfdisk /dev/nvme0n1
		cfdisk /dev/nvme1n1
		mdadm -C /dev/md3 -l raid0 -n 2 /dev/nvme[0-1]n1p5
		
		echo "Verify creation of /dev/md3"
		cat /proc/mdstat
		mdadm -E /dev/nvme[0-1]n1p5
		mdadm --detail /dev/md3
		
		echo "Formatting..."
		mkfs.ext4 /dev/md3 -L stripe7tb
		
		echo "Creating mountpoint & filesystem entries..."
		echo "# /dev/md3" >> /etc/fstab
		echo "/dev/md3 /home/$useraccount/.local/share/openethereum/ ext4 defaults 0 0" >> /etc/fstab
		mkdir -p /home/$useraccount/.local/share/openethereum/
		mount /home/$useraccount/.local/share/openethereum/
		chown -R $useraccount:$useraccount /home/$useraccount/.local/share/openethereum/
		
	fi
	
	# packages
	apt-get install unzip
	
		# create unitfile
	tee "/etc/systemd/system/openethereum.service" <<EOD
[Unit]
Description=ETH archive node (openethereum)
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/
ExecStart=/home/$useraccount/oe/openethereum --pruning=archive --no-warp --db-compaction=ssd --cache-size-db=15360
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
	
else
	
	# download openethereum
	mkdir oe
	cd oe
	wget https://github.com/openethereum/openethereum/releases/download/v3.0.1/openethereum-linux-v3.0.1.zip
	unzip openethereum-linux-v3.0.1.zip
	chmod +x oe/ethkey
	chmod +x oe/ethstore
	chmod +x oe/openethereum
	chmod +x oe/openethereum-evm
	
	echo -e "Run 'sudo systemctl start openethereum' & 'sudo systemctl enable openethereum'"
	echo "To see how your indexer is doing, run 'sudo journalctl --follow -o cat -u openethereum' (ctrl+c to stop the logview)."
	
fi
