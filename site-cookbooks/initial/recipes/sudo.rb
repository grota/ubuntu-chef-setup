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

include_recipe "initial::packages"
include_recipe "initial::dropbox"

execute 'regenerate perl locales' do
  command 'locale-gen it_IT.UTF-8'
end

%w[mysql-client libmysqlclient-dev mysql-server].each do |p|
  package p
end

include_recipe "initial::apache"
