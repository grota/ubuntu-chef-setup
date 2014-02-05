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

user "grota" do
  shell "/bin/bash"
  home '/home/grota'
  # a stub initial one
  password '$6$MUVQUZ1h$a.T34Cemc4z1OWp6BYV1LfHXrUSf4KTzN4RC2U/MNbN3CBJUXYr9IPBmt9Oko34osRgQLYasXPFDo87Zutntc0'
  supports :manage_home => true
end
include_recipe "initial::sudoers"

include_recipe "initial::apt"
include_recipe "apt::default"
include_recipe "initial::etckeeper"

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

include_recipe "initial::php"
include_recipe "initial::apache"
