#!/bin/bash
set -e
if [ -z $SUDO_USER  ]; then
  echo "Not running as sudo, bailing out"
  exit 1
fi

exists() {
  if command -v $1 >/dev/null 2>&1
  then
    return 0
  else
    return 1
  fi
}

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
  apt-get install -y curl < /dev/null
fi

if ! exists chef-solo; then
  echo Installing chef.
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi

TARGET_USER=$SUDO_USER
if command grep -q vboxsf /etc/group; then
  echo Found vboxsf group, assuming we are in Virtualbox, adding $TARGET_USER to vboxsf group.
  usermod -a -G vboxsf $TARGET_USER
fi

chef-solo -c sudo.rb
sudo -u $TARGET_USER chef-solo -c user.rb
