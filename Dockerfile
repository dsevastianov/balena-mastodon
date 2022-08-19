FROM tootsuite/mastodon:v3.5.3

COPY .env.production /opt/mastodon

USER root
RUN install -d -o mastodon  /mastodon/public/system
USER mastodon
