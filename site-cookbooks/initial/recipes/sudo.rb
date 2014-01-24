#
# Cookbook Name:: site-cookbooks/initial
# Recipe:: default
#
# Copyright (C) 2014 Giuseppe Rota
#
# All rights reserved - Do Not Redistribute

if node['initial'].nil?
  Chef::Application.fatal! "You must set the node['initial'] attribute in chef-solo mode."
end

include_recipe "apt::default"
# required by rvm
package "gawk"
include_recipe "git::default"
include_recipe "php"
include_recipe "mysql::server"
include_recipe "mysql::client"

# let's just install apache2 without using the community cookbook,
# there are too many incompatibilities between apache 2.2 and 2.4
package "apache2"
include_recipe "initial::packages"
include_recipe "initial::dropbox"
