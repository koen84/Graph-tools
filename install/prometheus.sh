#!/bin/bash

echo "Installer for 'Graph-ETH' on 'Ubuntu 18.04'"

# variables
useraccount="graph"
unitname=prometheus
dl_url="https://github.com/prometheus/prometheus/releases/download/v2.20.1/prometheus-2.20.1.linux-amd64.tar.gz"

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
Description=Prometheus monitoring
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/prometheus
ExecStart=/home/$useraccount/prometheus/prometheus --config.file=/home/$useraccount/prometheus/config/prometheus.yml
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

	mkdir prometheus
	cd prometheus
	wget $dl_url
	tar -xzf prometheus* --strip 1
	
	mkdir config

	tee "config/prometheus.yml" <<EOD
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:9090']
EOD

	echo -e "Run 'sudo systemctl start $unitname' & 'sudo systemctl enable $unitname'"
	echo "To see how your indexer is doing, run 'sudo journalctl --follow -o cat -u $unitname' (ctrl+c to stop the logview)."

fi
