FROM tootsuite/mastodon:v3.5.3

USER root
RUN mkdir -p /var/cache/apt/archive/partial && apt-get update && apt-get  -y install postgresql-client
RUN cp /run/secrets/.env.production /opt/mastodon

