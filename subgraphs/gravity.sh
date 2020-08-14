#!/bin/bash

echo "Installer for 'Graph-subgraph' on 'Ubuntu 18.04'"
echo "Using httpie instead of graph-cli"

# sudo apt-get install httpie

http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="4" params:='{"name": "jannis/gravity"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="4" method="subgraph_deploy" params:='{"name": "jannis/gravity", "ipfs_hash": "QmbeDC4G8iPAUJ6tRBu99vwyYkaSiFwtXWKwwYkoNphV4X", "node:id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="4" method="subgraph_reassign" params:='{"name": "jannis/gravity", "ipfs_hash": "QmXKwSEMirgWVn41nRzkT3hpUBw29cp619Gx58XW6mPhZP", "node_id": "nothing"}'
