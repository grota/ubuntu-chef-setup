#!/bin/bash

if [ -z "$1" -o "xx$1" = "xxvirt" ]; then
  sudo usermod -a -G vboxsf grota
fi
sudo apt-get install -y curl
curl -L https://www.opscode.com/chef/install.sh | sudo bash
