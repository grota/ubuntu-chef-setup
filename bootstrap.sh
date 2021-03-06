#!/bin/bash
set -e

exists() {
  if command -v $1 >/dev/null 2>&1
  then
    return 0
  else
    return 1
  fi
}

# also make sure we are not running in a working copy during development
# it's a weak but good enough check.
if [ "$(ls -A .)" -a ! -f bootstrap.sh ]; then
  echo "Current Dir is not empty, bailing out"
  exit 1
fi

if [ ! -d cookbooks ]; then
  echo "Cookbooks dir not found, downloading the archive."
  wget -q -O ubuntu-chef-workout.tar.gz https://github.com/grota/ubuntu-chef-workout/archive/master.tar.gz
  tar --strip-components=1 -xzf ubuntu-chef-workout.tar.gz
  rm -f ubuntu-chef-workout.tar.gz
fi

if ! exists curl; then
  echo Installing curl.
  sudo apt-get install -y curl < /dev/null
fi

if ! exists chef-solo; then
  echo Installing chef.
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi

if command grep -q vboxsf /etc/group; then
  echo Found vboxsf group, assuming we are in Virtualbox, adding $USER to vboxsf group.
  sudo usermod -a -G vboxsf $USER
fi

sudo chef-solo -c sudo.rb
chef-solo -c user.rb
