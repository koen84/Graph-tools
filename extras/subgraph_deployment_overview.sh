#!/bin/bash

# sudo apt-get install httpie

#which subgraph is on which node
http post http://localhost:8030/graphql query='{ indexingStatuses { subgraph node } }'
