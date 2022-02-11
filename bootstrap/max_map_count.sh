#! /bin/bash

# increase max_map_count due to sonarqube container startup error as below
   # ERROR: [1] bootstrap checks failed. You must address the points described in the following [1] lines before starting Elasticsearch.
   # bootstrap check failure [1] of [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

echo "increase vm.max_map_count to 262144"
sudo sysctl -w vm.max_map_count=262144
