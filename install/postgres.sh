#!/bin/bash

echo "Installer for 'Graph-Postgres' on 'Ubuntu 18.04'"

#variables
ethrpc="mainnet:https://mainnet.infura.io/v3/<project_id>"

# CHECK root
if ! [ $(id -u) = 0 ]; then
   echo "Script must be run as root / sudo."
   exit 1
fi

# install postgres
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update
apt-get install -y postgresql

# prepare postgres
#echo -e "$(tput setaf 3)Run '\password postgres' to set password\nRun '\q' to exit.$(tput sgr0)"
#sudo -u postgres psql postgres
read -p "Enter password for postgres : " psql_pwd
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '$psql_pwd';"
sudo -u postgres createdb graph-node

cat <<EOD > "$HOME/run_graph.sh"
#!/bin/bash
source $HOME/.cargo/env
cd $HOME/graph-node
cargo run -p graph-node --release -- \\
  --postgres-url postgresql://postgres:$psql_pwd@localhost:5432/graph-node \\
  --ethereum-rpc $ethrpc \\
  --ipfs https://testnet.thegraph.com/ipfs/
EOD

chmod +x $HOME/run_graph.sh
