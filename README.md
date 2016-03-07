*This is a work in progress.*

Kegbot
======
This repository hosts the brains for our beer consumption. It is an
AWS-specific deployment of [Kegbot
Server](https://github.com/Kegbot/kegbot-server).

Overview
--------
The server lives on an EC2 instance. The EC2 instance is part of an autoscaling
group.  The autoscaling group has a launch configuration. The launch
configuration is Ubuntu 14.04 with a custom [cloud-init
script](https://github.com/zackhsi/kegbot-aws/blob/master/cloud_init) (user
data).

The cloud-init script:

1. Installs git.
1. Clones this repository to `/srv/repos/kegbow-aws`.
1. Installs [salt](https://github.com/saltstack/salt).
1. Configures the salt minion to run masterless.
1. Runs highstate

Running
[highstate](https://github.com/zackhsi/kegbot-aws/blob/master/salt/states/kegbot/init.sls)
sets up the server, per https://kegbot.org/docs/server/install/.
