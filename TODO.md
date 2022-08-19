1. Figure out minimum config
2. readme
3. ElasticSearch requires `sysctl -w vm.max_map_count=262144` on host level
4. Decide on Tor
5. Mastodon server warmup (it can take several minutes for the new deployment)
6. Look into simplification of Postgres setup
7. Get rid of docker for Traefik, it doesn't look like we need dynamic configuration here just yet