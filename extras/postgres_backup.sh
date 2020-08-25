#!/bin/bash
# vars
dest=$HOME/backups
today=$(date +%y%m%d-%H%M)

#logic
mkdir -p $dest
sudo -u postgres pg_dumpall | gzip -cn > $dest/pg_backup_$today.gz
