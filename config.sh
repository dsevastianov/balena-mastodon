#!/usr/bin/env bash

docker pull tootsuite/mastodon
declare -A vars
vars[SECRET_KEY_BASE]=$(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake secret)
vars[OTP_SECRET]=$(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake secret)
eval $(docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake mastodon:webpush:generate_vapid_key) 
vars[VAPID_PRIVATE_KEY]=$VAPID_PRIVATE_KEY 
vars[VAPID_PUBLIC_KEY]=$VAPID_PUBLIC_KEY

for key in "${!vars[@]}"; do
  sed -i '' "s/$key=.*/$key=${vars[$key]}/g" ./.balena/secrets/.env.production
done