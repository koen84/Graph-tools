#!/bin/bash

# sudo apt-get install httpie

# syncstatus of subgraphs
http post http://localhost:8030/graphql query='{
  indexingStatuses {
    subgraph
    synced
    fatalError {
      handler
    }
    chains {
      ... on EthereumIndexingStatus {
        latestBlock { number hash }
        chainHeadBlock { number hash }
      }
    }
  }
}'
