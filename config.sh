#!/usr/bin/env bash

docker pull tootsuite/mastodon
SECRET_KEY_BASE=$(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake secret)
sed -i '' "s/SECRET_KEY_BASE=.*/SECRET_KEY_BASE=${SECRET_KEY_BASE}/g" ./.balena/secrets/.env.production

OTP_SECRET=$(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake secret)
sed -i '' "s/OTP_SECRET=.*/OTP_SECRET=${OTP_SECRET}/g" ./.balena/secrets/.env.production

eval $(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake mastodon:webpush:generate_vapid_key) 
sed -i '' "s/VAPID_PRIVATE_KEY=.*/VAPID_PRIVATE_KEY=${VAPID_PRIVATE_KEY}/g" ./.balena/secrets/.env.production
sed -i '' "s/VAPID_PUBLIC_KEY=.*/VAPID_PUBLIC_KEY=${VAPID_PUBLIC_KEY}/g" ./.balena/secrets/.env.production

echo "Done generating secrets in ./.balena/secrets/.env.production"