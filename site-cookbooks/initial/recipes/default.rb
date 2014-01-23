#
# Cookbook Name:: site-cookbooks/initial
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute

include_recipe "apt::default"
# required by rvm
package "gawk"
include_recipe "git::default"
include_recipe "rvm::user"
include_recipe "php"
include_recipe "mysql::server"
include_recipe "mysql::client"
include_recipe "apache2"
my_packages = %w{tmux ikiwiki libtext-markdown-perl libtext-multimarkdown-perl libhighlight-perl libxml-writer-perl}
my_packages.each do |pkg|
  package pkg
end
