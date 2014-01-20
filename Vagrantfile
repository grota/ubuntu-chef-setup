# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

def load_user_lib( filename )
    JSON.parse( IO.read(filename)  )
end
node_json = load_user_lib('dna.json')

Vagrant.configure("2") do |config|
  config.vm.hostname = "ubuntu-chef-workout-berkshelf"
  config.vm.box = "trusty-14.04-cloudimg-i386"
  # Image prepared by canonical for vagrant
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

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
    chef.json = node_json
    chef.run_list = node_json["run_list"]
  end
end
