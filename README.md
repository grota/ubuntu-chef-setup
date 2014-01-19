ubuntu-chef-workout
===================

This repo contains code whose purpose is to explore chef's
(and vagrant/berkshelf/kitchen) capabilities in provisioning ubuntu 14.04.

Usage
=====

`wget -q -O - https://github.com/grota/ubuntu-chef-workout/raw/master/bootstrap.sh | sudo bash`

Kitchen Testing
===============

There are many configuration parameters described on the [kitchen-vagrant][1]
github gem repo page (provider, synced_folders, network, customize mem/cpu).

Issues
======

See the [issue][3].

[1]: https://github.com/test-kitchen/kitchen-vagrant
[2]: https://github.com/fnichol/chef-rvm
[3]: https://github.com/grota/ubuntu-chef-workout/issues/1
