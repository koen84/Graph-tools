#!/bin/bash

# CHECK root
if ! [ $(id -u) = 0 ]; then
   echo "Script must be run as root / sudo."
   exit 1
fi

# add repo
apt-get install -y apt-transport-https software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
echo "deb https://packages.grafana.com/enterprise/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

# install grafana
apt-get update
apt-get install -y grafana

# start grafana
systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server

echo "Surf to localhost:3000 and login with admin:admin"
