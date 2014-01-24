ubuntu-chef-setup
=================

This repo contains code whose purpose is to bootstrap my development machine.

Usage
=====

- `wget -q -O - https://github.com/grota/ubuntu-chef-workout/raw/master/bootstrap.sh | bash`
- You can optionally prepare a Dropbox backup in the `dropbox_backup` dir in the cwd.

Notes
=====

**chef-solo** is used for provisioning. Vagrant/Berkshelf/test-kitchen have
been used to develop/test this project.

It will always be a work-in-progress but it is already useful because it sets up:

- various useful packages (compile dependencies, system ruby, LAMP)
- a user-installed rvm (with ruby 2.1.0)
- and most importantly my dotfiles environment (vim/tmux/hub/aliases/functions/...)

There are many configuration parameters described on the [kitchen-vagrant][1]
github gem repo page (provider, synced_folders, network, customize mem/cpu).

[1]: https://github.com/test-kitchen/kitchen-vagrant
[2]: https://github.com/fnichol/chef-rvm
