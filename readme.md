# Mastodon on Balena

## What
[Mastodon](https://joinmastodon.org/) is a popular open source microblogging platform. It uses Activity Pub specification to implement federation. In practice it means that one can subscribe and interract with users from external servers and see activity across the network.

## Why
Setting up your own Mastodon server from scratch requires some effort. At a minimum, you'll need your own domain, mail service account, and fairly deep technical knowledge. There is a number of hosting solutions out there that can furnish a server for a moderate subscription fee.

For those who wants to have more control, Balena cloud provides an attractive alternative. If you have an old laptop or an inexpensive device like Intel Nuc or Raspbery Pi, Balena makes it a breeze to deploy Mastodon, with one noticable benefit: **you don't even need your own domain!** 

## How

1. Create an account on [Balena-cloud.com](https://dashboard.balena-cloud.com/login)
2. Click on "Getting started" for step-by-step walkgthrough of onboarding your device with Balena. You can go ahead and use Balena-mastodon project right away to push Mastodon on you device or play around with our Hello world project to get comfortable. You'll need a few more things to get started with Mastodon on Balena:  
   1. Mail service for handling registrations, password resets, etc. [Sendgrid](https://app.sendgrid.com/), [Mailchimp](https://mailchimp.com/) or just GMail ([here](https://kinsta.com/blog/gmail-smtp-server/) is a good walkthrough) - any one will work, and the free option is fine for most usecases
   2.  If you prefer to have your own domain, make sure it's pointing to the IP of your device. Typically you will need to do redirect HTTPS on port 443 in your router for the incoming traffic to hit your device. 
   3.   If you're fine with Balena domain name, it will look something like `6c45c13f642b9487a21f159392b33aac.balena-devices.com`
3. Clone this git repo locally. Now it's time to update configuration. 
   1. Open `.gitignore` and uncomment `.balena` . This is the directory holding all the secrtets, we want to make sure it's not pushed to some git branch by mistake
   2. Open `docker-cmpose.yml` in your favorite editor and make sure to update the following:
      1. `LOCAL_DOMAIN` - this is your domain for federation, it cannot be changed once the server is up and running. Set it to your custom domain or Balena-cloud address, it can be found in Balena-cloud dashboard (Public Device URL)
      2. `LE_EMAIL` under caddy service definition - your email to use for LetsEncrypt certificate management.
   3. Open `.balena/secrets/.env.production` and update SMTP section with your mail service credentials. Save and close the file.    
   4. For the rest of the setup, there are two options:
      * Option one is the easiest, it assumes you already have docker [installed](https://docs.docker.com/engine/install/). Run `config.sh` in the shell, it will generate keys using Mastodon image and update your configuration files. 
      * If for wahtever reason you don't feel like installing docker (please let me know why), you will need to provide following data in `.balena/secrets/.env.production`. [Here's](https://sleeplessbeastie.eu/2022/05/02/how-to-take-advantage-of-docker-to-install-mastodon/) a good guide to generating them manually with Openssl: 
        * `SECRET_KEY_BASE`
        * `OTP_SECRET`
        * `VAPID_PRIVATE_KEY`
        * `VAPID_PUBLIC_KEY`. 
4. Finally, run `balena push <fleet_name>` from the root of the clonned repo on your machine. Once you see a unicorn (it may take a few minutes), you may follow it with `balena logs <device_id> -t` to monitor the deployment. You should see something like Fig. 1. Don't worry, if there's an error in your configuration you can always run push command again, your data will survive it.
5. Open public device URL in a new browser window (Fig. 2). It's time to create your admin user.
   1. Enter your username, email, and password, check "I agree" box, and click Sign Up. Mastodon will send you an email with the link to confirm (if SMTP is configured properly). Feel free to ignore it, we will have to use Mastodon admin utility to set permissions anyway.
   2. Head to Balena-cloud dashboard for the device. Open terminal session for `web` service (Fig. 3). This is where you can run admin tasks as described [here](https://docs.joinmastodon.org/admin/tootctl/).
   3. Execute `tootctl accounts modify <your_user_name> --role admin --confirm --approve`
   4. Enjoy!
   
---
## Notes
1. ElasticSearch container is commented out to match current state of Mastodon repo. Feel free to uncomment and change `.balena/secrets/.env.production` file accordingly and `balena push` when you feel like it.  **NOTE: ElasticSearch requires `sysctl -w vm.max_map_count=262144` to be executed on the host.**
2. If you have concerns about the safety of your secrets in `.balena/secrets/.env.production`, please refer to [this](https://www.balena.io/docs/learn/more/masterclasses/cli-masterclass/#81-build-time-secrets) explanation for the details.