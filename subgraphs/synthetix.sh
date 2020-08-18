#!/bin/bash

echo "Installer for 'Graph-subgraph' on 'Ubuntu 18.04'"
echo "Using httpie instead of graph-cli"

# sudo apt-get install httpie

echo "Previous version used wrong ipfs_hash."
#http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="3" params:='{"name": "synthetixio-team/synthetix"}'
#http post 127.0.0.1:8020 jsonrpc="2.0" id="3" method="subgraph_deploy" params:='{"name": "synthetixio-team/synthetix", "ipfs_hash": "QmSXzWZhbDgDg9YyDeivFqYBc1zxESyBYBH3W9CzmupYQd", "node_id":"graph_node1"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "synthetixio-team/synthetix", "ipfs_hash": "QmSXzWZhbDgDg9YyDeivFqYBc1zxESyBYBH3W9CzmupYQd", "node_id": "nothing"}'

# remove wrong version
#http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_remove" id="3" params:='{"name": "synthetixio-team/synthetix"}'

http post 127.0.0.1:8020 jsonrpc="2.0" method="subgraph_create" id="3" params:='{"name": "synthetixio-team/synthetix"}'
http post 127.0.0.1:8020 jsonrpc="2.0" id="3" method="subgraph_deploy" params:='{"name": "synthetixio-team/synthetix", "ipfs_hash": "Qme2hDXrkBpuXAYEuwGPAjr6zwiMZV4FHLLBa3BHzatBWx", "node_id":"graph_node3"}'

# for redeploying to another server (or stop indexing if unexisting node-id)
#http post 127.0.0.1:8020 jsonrpc="2.0" id="1" method="subgraph_reassign" params:='{"name": "synthetixio-team/synthetix", "ipfs_hash": "Qme2hDXrkBpuXAYEuwGPAjr6zwiMZV4FHLLBa3BHzatBWx", "node_id": "nothing"}'
