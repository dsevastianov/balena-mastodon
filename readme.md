# Mastodon On balena

This is a condensed guide for running Mastodon on any compatible device with [balenaCloud](https://dashboard.balena-cloud.com/login). The readme is limited to the bare minumum required for starting the service on your own device. For more comprehensive walkthrough, please see [here](https://www.balena.io/blog/mastodon-on-balena/).

## Minimum configuration

1. Create an account on [balenaCloud](https://dashboard.balena-cloud.com/login). No credit card necessary
2. Decide whether you want to use your own domain or the one provided by the Balena Cloud. Balena URL can be found on the Balena Dashboard under PUBLIC DEVICE URL
3. Clone the repo `git clone https://github.com/dsevastianov/balena-mastodon`, update LOCAL_DOMAIN in `docker-compose.yml` with chosen domain name (no slashes), Balena domain name will look something like `6c45c13f642b9487a21f159392b33aac.balena-devices.com`
4. Open `.gitignore` and uncomment `.balena`. This will ensure that your secrets will not be committed by mistake
5. Assuming that you have Docker installed on your machine, run `config.sh` (or `config.ps1` on Windows) to generate secrets and update relevant variables in `.balena/secrets/.env.production`. Alternatively, update the following variables manually: `SECRET_KEY_BASE`, `OTP_SECRET`, `VAPID_PRIVATE_KEY`, `VAPID_PUBLIC_KEY`.
6. `balena push <your_fleet_name>`
7. Once the deployment is complete, open chosen domain name in the borwser. Enter username, email, and password and click Sign Up button
8. Go to balenaCloud Dashboard and open terminal session for `web` service
9. Execute `tootctl accounts modify <username> --role admin --confirm --approve`
10. Now you can login to your Mastodon server with `<username>`, no email confirmation neccesary

## Further steps
You'll need to provide SMTP details in `.balena/secrets/.env.production` to start onboarding new users automatically. See Mastodon documentation on other configuration options, including support for external storage with Amazon S3 and SWIFT, Tor for darknet, ElasticSearch for full text search, etc.