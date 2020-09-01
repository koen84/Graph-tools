#!/bin/bash

echo "Installer for 'Graph-SEED' on 'Ubuntu 18.04'"

# variables
useraccount="graph"

# CHECK root
if ! [ $(id -u) = 0 ]; then
   echo "Script must be run as root / sudo."
   exit 1
fi

apt-get install -y cifs-utils linux-modules-extra-$(uname -r)
mkdir $HOME/backups

echo "Make sure to add an entry into '/etc/fstab' and then run 'sudo mount -a'"
