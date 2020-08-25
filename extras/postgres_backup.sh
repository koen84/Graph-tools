#!/bin/bash
# vars
dest=$HOME/backups
pguser=postgres
today=$(date +%y%m%d-%H%M)

#logic
mkdir -p $dest
sudo -u $pguser pg_dumpall | gzip -cn > $dest/pg_backup_$today.gz
