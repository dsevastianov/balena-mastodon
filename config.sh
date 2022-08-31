#!/usr/bin/env bash

docker pull tootsuite/mastodon
SECRET_KEY_BASE=$(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake secret)
OTP_SECRET=$(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake secret)
VAPID=$(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake mastodon:webpush:generate_vapid_key)
echo "SECRET_KEY_BASE $SECRET_KEY_BASE"
echo "OTP_SECRET $OTP_SECRET"
echo "VAPID $VAPID"