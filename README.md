ubuntu-chef-workout
===================

This repo at the moment only contains code whose purpose is to explore chef's
(and vagrant/berkshelf/knife-solo) capabilities in provisioning ubuntu 14.04.

Usage
=====

`wget -q -O - https://github.com/grota/ubuntu-chef-workout/raw/master/bootstrap.sh | sudo bash`

Notes
=====

There are many configuration parameters described on the [kitchen-vagrant][1]
github gem repo game (provider, synced_folders, network, customize mem/cpu).

TODO
====

See the [issues][3].

[1]: https://github.com/test-kitchen/kitchen-vagrant
[2]: https://github.com/fnichol/chef-rvm
[3]: https://github.com/grota/ubuntu-chef-workout/issues
