# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

def load_json_file(filename)
    JSON.parse( IO.read(filename)  )
end
node_json_sudo = load_json_file('sudo.json')
# Vagrant specific config
node_json_sudo['initial']['user'] = 'vagrant'
node_json_sudo['initial']['dropbox']['arch'] = 'i386'
node_json_sudo['initial']['dropbox']['source_dir'] = '/vagrant/dropbox_backup'
node_json_sudo['initial']['dropbox']['target_dir'] = '/home/vagrant/Dropbox'
run_list_sudo = node_json_sudo.delete("run_list")

node_json_user = load_json_file('user.json')
node_json_user['rvm']['user_installs'][0]['user'] = 'vagrant'
node_json_user['initial']['user'] = 'vagrant'
node_json_user['initial']['dropbox']['target_dir'] = '/home/vagrant/Dropbox'
run_list_user = node_json_user.delete("run_list")

# This is left as a note, the rvm::vagrant only fixes
# the issue of chef+rvm when rvm is installed system-wide
# (Not our case). chef-solo will still fail interactively
# but it's ok, just switch to system ruby beforehand.
#node_json_sudo['rvm']['vagrant'] = {
  #'system_chef_solo' => '/usr/bin/chef-solo'
#}
#node_json_sudo['rvm']['root_path'] = '/home/vagrant/.rvm'
#run_list = node_json_sudo.delete("run_list").unshift('recipe[rvm::vagrant]')


Vagrant.configure("2") do |config|
  config.vm.hostname = "ubuntu-chef-workout-berkshelf"
  config.vm.box = "trusty-14.04-cloudimg-i386"
  # Image prepared by canonical for vagrant
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

  config.omnibus.chef_version = :latest

  # required to clone a r/w repo from github
  config.ssh.forward_agent = true

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "33.33.33.10"
  #config.vm.provider "virtualbox" do |vb|
    #vb.customize ["modifyvm", :id, '--memory', 2048]
  #end

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :chef_solo do |chef|
    chef.json = node_json_sudo
    chef.run_list = run_list_sudo
    chef.verbose_logging = true
  end
  config.vm.provision :chef_solo do |chef|
    chef.json = node_json_user
    chef.run_list = run_list_user
    chef.verbose_logging = true
  end
end
