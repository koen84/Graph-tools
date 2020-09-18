#!/bin/bash

## install packages
# sudo apt-get install httpie jq

## get data from indexer
graphstati=$( \
http post http://localhost:8030/graphql query='{
  indexingStatuses {
    subgraph
#    synced
    node
    fatalError {
      handler
    }
    chains {
      ... on EthereumIndexingStatus {
        network
        latestBlock { number }
        chainHeadBlock { number }
      }
    }
  }
}' \
 | jq -c '.[] | .[] | .[]' \
)

#echo "$graphstati"

## Processing
echo -e "\nSubraph-indexer overview"

## get chainhead
chainhead=$(echo "$graphstati" | head -n 1 | jq '.chains[].chainHeadBlock.number' | sed 's/"//g')
echo -e "ETH head : $chainhead\n"

## get lags
echo "$(tput setaf 5)subgraph hash                                  : eth net : node id     : last blk :lag: error$(tput sgr0)"
graphlags=""
for graphline in $graphstati
do
        subgraph=$(echo "$graphline" | jq '.subgraph' | sed 's/"//g')
        lastblock=$(echo "$graphline" | jq '.chains[].latestBlock.number' | sed 's/"//g')
        lagblocks=$(expr $chainhead - $lastblock)
        fatalerror=$(echo "$graphline" | jq -c '.fatalError')
        nodeid=$(echo "$graphline" | jq '.node' | sed 's/"//g')
        ethnet=$(echo "$graphline" | jq '.chains[].network' | sed 's/"//g')
        echo "$subgraph : $ethnet : $nodeid : $lastblock : $lagblocks : $fatalerror"
done

echo
