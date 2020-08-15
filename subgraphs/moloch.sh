#!/bin/bash

echo "Installer for 'Graph-subgraph' on 'Ubuntu 18.04'"
echo "Using httpie instead of graph-cli"

# sudo apt-get install httpie

http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="1" params:='{"name": "molochventures/moloch"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_deploy" params:='{"name": "molochventures/moloch", "ipfs_hash": "QmTXzATwNfgGVukV1fX2T6xw9f6LAYRVWpsdXyRWzUR2H9", "node:id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "molochventures/moloch", "ipfs_hash": "QmTXzATwNfgGVukV1fX2T6xw9f6LAYRVWpsdXyRWzUR2H9", "node_id": "nothing"}'

