#!/bin/bash

echo "Installer for 'Graph Agent & Service' on 'Ubuntu 18.04'"

# variables
useraccount="graph"
mnemonic="one two three four five six seven eight nine ten eleven twelve"
pg_pwd="postgrespasword"
domain="example.com"
con_query="https://graph.$domain"
con_service="https://service.$domain"
con_postgres="postgres.$domain"
nodeids="graph_node1,graph_node3"
geo="0.12345 0.12345"


# logic
if [ $USER != "$useraccount" ]; then
	# CHECK root
	if ! [ $(id -u) = 0 ]; then
	   echo "Script must be run as root / sudo."
	   exit 1
	fi
	
	# packages
	apt-get install -y nodejs npm tmux libsecret-1-dev
	
	# user account
	adduser --disabled-password --gecos "" $useraccount

	# upgrade node to latest stable
	npm cache clean -f
	npm install -g n
	n stable
	PATH="$PATH"

	# verify nodeJS / NPM install
	node -v
	npm -v
	
	# login & graph npm packages
	echo "$(tput setaf 3)WARNING$(tput sgr0) : make sure you have credentials emailed by the graph at hand."
	npm login --registry https://testnet.thegraph.com/npm-registry/
	npm install -g --registry https://testnet.thegraph.com/npm-registry/ @graphprotocol/indexer-agent @graphprotocol/indexer-service
	
	# create unitfiles
	cat <<EOD > "/etc/systemd/system/graph_service.service"
[Unit]
Description=Graph service
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/
ExecStart=/home/$useraccount/graph_service.sh
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

	cat <<EOD > "/etc/systemd/system/graph_agent.service"
[Unit]
Description=Graph agent
After=network-online.target

[Service]
User=$useraccount
WorkingDirectory=/home/$useraccount/
ExecStart=/home/$useraccount/graph_agent.sh
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
	echo "login as $useraccount by running 'su $useraccount' and start script again"
	su $useraccount
	exit 0

else 

	echo "Don't forget to update permissions in postgres server, firewall & pg_hba.conf"
	echo "Create DB on postgres server with 'sudo -u postgres createdb graph-access'"

cat <<EOD > "$HOME/graph_agent.sh"
#!/bin/bash
mnemonic="$mnemonic"
pg_pwd="$pg_pwd"

graph-indexer-agent start \
    --graph-node-query-endpoint $con_query:8000/ \
    --graph-node-admin-endpoint $con_query:8020/ \
    --graph-node-status-endpoint $con_query:8030/graphql \
    --index-node-ids $nodeids \
    --public-indexer-url $con_service/ \
    --indexer-management-port 18000 \
    --indexer-geo-coordinates $geo \
    --postgres-host $con_postgres \
    --postgres-port 5432 \
    --postgres-database graph-access \
    --postgres-username postgres \
    --postgres-password $pg_pwd \
    --network-subgraph-endpoint https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-rinkeby \
    --ethereum https://eth-rinkeby.alchemyapi.io/jsonrpc/demo/ \
    --mnemonic "$mnemonic"
EOD

chmod +x $HOME/graph_agent.sh

cat <<EOD > "$HOME/graph_service.sh"
#!/bin/bash

# variables
mnemonic="$mnemonic"
pg_pwd="$pg_pwd"

export SERVER_HOST=postgres.mindheartsoul.org
export SERVER_PORT=5432
export SERVER_DB_NAME=graph-access
export SERVER_DB_USER=postgres
export SERVER_DB_PASSWORD=$pg_pwd

graph-indexer-service start \
    --port 9090 \
    --graph-node-query-endpoint $con_query/ \
    --graph-node-status-endpoint $con_query:8030/graphql \
    --network-subgraph-endpoint https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-rinkeby \
    --ethereum https://eth-rinkeby.alchemyapi.io/jsonrpc/demo/ \
    --mnemonic "$mnemonic"
EOD

chmod +x $HOME/graph_service.sh

fi
