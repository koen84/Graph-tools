# Graph-tools (ARCHIVED)
Tools for Mission Control, aimed at running baremetal on Ubuntu 18.04 LTS.
YMMV - use at your own risk

## ARCHIVED
This repo is now for historical purposes.  The installers are outdated for the current mainnet & testnet.  Please refer to the new [Graph Install Suite](https://github.com/MindHeartSoul/Graph-InstallSuite) instead.
Some files in this repo might still be relevant : e.g. [grafana indexer dashboard modification](https://github.com/koen84/Graph-tools/blob/master/files/indexing-status_not-removed.json), [postgres backup script](https://github.com/koen84/Graph-tools/blob/master/extras/postgres_backup.sh) & [CLI subgraph overview](https://github.com/koen84/Graph-tools/blob/master/extras/subgraph_overview.sh)

## Install scripts
* create a fresh non-sudo user
* need to be run as root / sudo
* some scripts need to be re-run as new the new user
* openethereum has a routine for creating a stripe array and mounting it, which is disabled by default (as it makes several assumptions)
* some config needs to be done manual still, pointers via echo or comments
* different scripts can be run on the same or on different servers

## Subgraphs
* used for creating and deploying respective subgraphs via httpie

## Extras
* useful little snippets, need to be run on corresponding server
* postgres backup can be run manual or via cron, needs read access to all databases


## Disk size
* Turbogeth : 641 GiB (actual usage) + approx 200 GB temp space according to docs.  Compressed [snapshot](https://github.com/koen84/Graph-tools/blob/master/snapshots/turbogeth-200805-data.mdb.xz.torrent) is 250 GiB.
* Openethereum : estimated at almost 5TB.  Needs to be SSD or won't catch up.

*Have fun ^_^*


### Donations welcome
* BTC : 3Lmfs7Y9fxJWgKMyANzTsNRdppkjk5wzBG
* ETH : 0xD3136a99Be75bEB3565c386cA28076E3A5621C56
