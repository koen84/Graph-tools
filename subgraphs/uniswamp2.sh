#!/bin/bash

echo "Installer for 'Graph-subgraph' on 'Ubuntu 18.04'"
echo "Using httpie instead of graph-cli"

# sudo apt-get install httpie

http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="2" params:='{"name": "uniswap/uniswap-v2"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="2" method="subgraph_deploy" params:='{"name": "uniswap/uniswap-v2", "ipfs_hash": "QmXKwSEMirgWVn41nRzkT3hpUBw29cp619Gx58XW6mPhZP", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "uniswap/uniswap-v2", "ipfs_hash": "QmXKwSEMirgWVn41nRzkT3hpUBw29cp619Gx58XW6mPhZP", "node_id": "nothing"}'
