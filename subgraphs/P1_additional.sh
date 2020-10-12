#!/bin/bash

echo "Installer for 'Graph-subgraph' on 'Ubuntu 18.04'"
echo "Using httpie instead of graph-cli"

# sudo apt-get install httpie
# There's no need for "subgraph_reassign" to contain the "name" info

## compound
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "graphitetools/compound"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "graphitetools/compound", "ipfs_hash": "QmdYA3zCs27962HNchhcjJbyfT3hZtLhANJuo1BsMv5YTs", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "graphitetools/compound", "ipfs_hash": "QmdYA3zCs27962HNchhcjJbyfT3hZtLhANJuo1BsMv5YTs", "node_id": "nothing"}'


## keeper dao
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "keeperdao/keeperdao"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "keeperdao/keeperdao", "ipfs_hash": "QmW6BrjSMPUSjMApTNYZShHi9XShgziC5YppGvqyjjAAX1", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "keeperdao/keeperdao", "ipfs_hash": "QmW6BrjSMPUSjMApTNYZShHi9XShgziC5YppGvqyjjAAX1", "node_id": "nothing"}'


## tellor dispute
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "tellor-io/tellor-dispute"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "tellor-io/tellor-dispute", "ipfs_hash": "QmbBHyLRN97BssF7w6MnULW92f7iaM7vX7fnNU6wDDj3fc", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "tellor-io/tellor-dispute", "ipfs_hash": "QmbBHyLRN97BssF7w6MnULW92f7iaM7vX7fnNU6wDDj3fc", "node_id": "nothing"}'


## curve
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "blocklytics/curve"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "blocklytics/curve", "ipfs_hash": "QmNs5fU6VkyGUsaNsa5sUHEKpzCA5AZWKJG8LaBrcCRpmW", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "blocklytics/curve", "ipfs_hash": "QmNs5fU6VkyGUsaNsa5sUHEKpzCA5AZWKJG8LaBrcCRpmW", "node_id": "nothing"}'


## opyn
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "aparnakr/opyn"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "aparnakr/opyn", "ipfs_hash": "QmNVmy3hA6JVqZfMGoQc68GsB9GzGiEVLjhR1pHLY2xwuS", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "aparnakr/opyn", "ipfs_hash": "QmNVmy3hA6JVqZfMGoQc68GsB9GzGiEVLjhR1pHLY2xwuS", "node_id": "nothing"}'

## protocol multi raw
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "aave/protocol-multy-raw"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "aave/protocol-multy-raw", "ipfs_hash": "QmaTCNvS72s7gULbrnKE9D4WaDA3HBD7yXUA9d2wGJUXHQ", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "aave/protocol-multy-raw", "ipfs_hash": "QmaTCNvS72s7gULbrnKE9D4WaDA3HBD7yXUA9d2wGJUXHQ", "node_id": "nothing"}'


## synthetix exchanges
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "synthetixio-team/synthetix-exchanges"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "synthetixio-team/synthetix-exchanges", "ipfs_hash": "QmNmLRx82a8FEvVr3aBahEReAj3fN4JSmHG2ufTEVwVR7z", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "synthetixio-team/synthetix-exchanges", "ipfs_hash": "QmNmLRx82a8FEvVr3aBahEReAj3fN4JSmHG2ufTEVwVR7z", "node_id": "nothing"}'


## mstable
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "mstable/mstable-protocol"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "mstable/mstable-protocol", "ipfs_hash": "QmWNP1jqMZm61G8FbsLzi9Mnii5qRXbkadBxXVHZPqzKri", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "mstable/mstable-protocol", "ipfs_hash": "QmWNP1jqMZm61G8FbsLzi9Mnii5qRXbkadBxXVHZPqzKri", "node_id": "nothing"}'


## synthetix rates
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "synthetixio-team/synthetix-rates"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "synthetixio-team/synthetix-rates", "ipfs_hash": "QmdbHP5ALcHda6UdCtZLYEwQJo7xTKKgUXMwMLLiCspYFE", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "synthetixio-team/synthetix-rates", "ipfs_hash": "QmdbHP5ALcHda6UdCtZLYEwQJo7xTKKgUXMwMLLiCspYFE", "node_id": "nothing"}'


## aave
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "aave/aave"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "aave/aave", "ipfs_hash": "QmU3qzWocSGuywhLonGiYmv22XS5sHatfEBp3vrJrRGdD6", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "aave/aave", "ipfs_hash": "QmU3qzWocSGuywhLonGiYmv22XS5sHatfEBp3vrJrRGdD6", "node_id": "nothing"}'


## balancer2 (stones)
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "balancer2/balancer2"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "balancer2/balancer2", "ipfs_hash": "QmXorTXBbcJ9YHH8YKjdz5KxVENz43fdXxciFHZHvi8m6c", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "balancer2/balancer2", "ipfs_hash": "QmXorTXBbcJ9YHH8YKjdz5KxVENz43fdXxciFHZHvi8m6c", "node_id": "nothing"}'


## balancer1 (clouds)
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "balancer1/balancer1"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "balancer1/balancer1", "ipfs_hash": "QmdZzqsVuLvW6wkuvw23zotUdSq3CQPqbWNgwfMztf2n3K", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "balancer1/balancer1", "ipfs_hash": "QmdZzqsVuLvW6wkuvw23zotUdSq3CQPqbWNgwfMztf2n3K", "node_id": "nothing"}'


## mintbase
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "mintbase/mintbase"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "mintbase/mintbase", "ipfs_hash": "QmW5UcMhXwXrMqRpTdT3MKB7HYDxbsp5oe9Atkuh4sgAA5", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "mintbase/mintbase", "ipfs_hash": "QmW5UcMhXwXrMqRpTdT3MKB7HYDxbsp5oe9Atkuh4sgAA5", "node_id": "nothing"}'


## known origin
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "known/known-origin"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "known/known-origin", "ipfs_hash": "QmUxpVrcmXRmJgi8CMXu8JPHABspnoaewQjDujc17bkGqR", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "known/known-origin", "ipfs_hash": "QmUxpVrcmXRmJgi8CMXu8JPHABspnoaewQjDujc17bkGqR", "node_id": "nothing"}'


## tokensets
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "tokensets/tokensets"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "tokensets/tokensets", "ipfs_hash": "QmZ6noN8Ek4dPpyvmSv4AdAtefVWtUsopBc8hFKFiWo1Uw", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "tokensets/tokensets", "ipfs_hash": "QmZ6noN8Ek4dPpyvmSv4AdAtefVWtUsopBc8hFKFiWo1Uw", "node_id": "nothing"}'


## uma
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "protofire/uma"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "protofire/uma", "ipfs_hash": "QmdJjt7nX7bZraGLRb93eJMQ9ND4SwoFQtA934N3FdxMBs", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "protofire/uma", "ipfs_hash": "QmdJjt7nX7bZraGLRb93eJMQ9ND4SwoFQtA934N3FdxMBs", "node_id": "nothing"}'


## known origin
http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "ianlapham/uniswapv2"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "ianlapham/uniswapv2", "ipfs_hash": "QmWTrJJ9W8h3JE19FhCzzPYsJ2tgXZCdUqnbyuo64ToTBN", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "ianlapham/uniswapv2", "ipfs_hash": "QmWTrJJ9W8h3JE19FhCzzPYsJ2tgXZCdUqnbyuo64ToTBN", "node_id": "nothing"}'
