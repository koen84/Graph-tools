# Graph-tools
Tools for Mission Control, aimed at running baremetal on Ubuntu 18.04 LTS.
YMMV - use at your own risk

## Install scripts
* create a fresh non-sudo user
* need to be run as root / sudo
* some scripts need to be re-run as new the new user
* openethereum has a routine for creating a stripe array and mounting it, which is disabled by default (as it makes several assumptions)

## Disk size
* Turbogeth : 641 GiB (actual usage) + approx 200 GB temp space according to docs.  Compressed [snapshot](https://github.com/koen84/Graph-tools/blob/master/snapshots/turbogeth-200805-data.mdb.xz.torrent) is 250 GiB.
* Openethereum : estimated at almost 5TB.  Needs to be SSD or won't catch up.

*Have fun ^_^*


### Donations welcome
* BTC : 3Lmfs7Y9fxJWgKMyANzTsNRdppkjk5wzBG
* ETH : 0xD3136a99Be75bEB3565c386cA28076E3A5621C56
