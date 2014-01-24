#
# Cookbook Name:: site-cookbooks/initial
# Recipe:: default
#
# Copyright (C) 2014 Giuseppe Rota
#
# All rights reserved - Do Not Redistribute

# we need to override the list of packages that the community cookbook
# rvm would like to install: we want to exclude git-core which is a
# transitional dummy package. Also, setting the attribute in the json
# file does not override the value so we have to do it here.
node.set['rvm']['install_pkgs']  = %w{sed grep tar gzip bzip2 bash curl}
include_recipe "rvm::user"
include_recipe "initial::dotfiles"
