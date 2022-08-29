# Mastodon on Balena

## What
[Mastodon](https://joinmastodon.org/) is a popular open source microblogging platform. It uses Activity Pub specification to implement federation. In practice it means that one can interract with users from external servers and see activity across the network.

## Why
Setting up your own Mastodon server from scratch requires some effort. At a minimum, you'll need your own domain, mail service account, and fairly deep technical knowledge. There is a number of hosting solutions out there that can furnish a server for a moderate subscription fee. 

For those who wants to have more control, Balena cloud provides an attractive alternative. If you have an old laptop or an inexpensive device like Intel Nuc or Raspbery Pie, Balena makes it a breeze to deploy Mastodon, with one noticable benefit: you don't even need your own domain! 

## How

1. Register on [Balena-cloud.com](https://dashboard.balena-cloud.com/login)
2. Click on "Getting started" for step-by-step walkgthrough of onboarding your device with Balena. You can go ahead and use Balena-mastodon project right away to push Mastodon on you device or play around with our Hello world project to get comfortable. You'll need a few more things to get started with Mastodon on Balena:
   * Preferred mail service for handling registrations, password resets, etc. [Sendgrid](https://app.sendgrid.com/), [Mailchimp](https://mailchimp.com/) or just GMail ([here](https://kinsta.com/blog/gmail-smtp-server/) is a good walkthrough) - any one will work, and the free option is fine for most usecases
   * If you prefer to have your own domain, make sure it's pointing to the IP of your device. Typically you will need to do redirect HTTPS on port 443 in your router to hit your device. 
   * If you're fine with Balena domain name, it will look something like *6c45c13f642b9487a21f159392b33aac.balena-devices.com*

---
## Notes
1. ElasticSearch container is commented out to match current state of Mastodon repo. Feel free to uncomment and change config accordingly. **ElasticSearch requires `sysctl -w vm.max_map_count=262144` to be executed on the host**