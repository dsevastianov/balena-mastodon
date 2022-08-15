1. Figure out minimum config
2. ElasticSearch requires `sysctl -w vm.max_map_count=262144` on host level
3. Decide on Tor
4. Mastodon server warmup (it can take several minutes for the new deployment)
5. Look into simplification of Postgres setup