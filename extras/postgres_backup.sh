#!/bin/bash
# vars
dest=$HOME/backups
pguser=postgres
today=$(date +%y%m%d-%H%M)

echo "pigz results same data size, but is about 3 times faster than gzip"
echo "install pigz with 'sudo apt-get install pigz' and then (un)comment the last 2 lines"

#logic
mkdir -p $dest
sudo -u $pguser pg_dumpall | gzip -cn > $dest/pg_backup_$today.gz
#sudo -u postgres pg_dumpall | pigz > $dest/pg_backup_$today.gz
