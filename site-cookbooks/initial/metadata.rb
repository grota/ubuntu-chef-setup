name             'initial custom cookbook'
maintainer       'Giuseppe Rota'
maintainer_email 'rota.giuseppe@gmail.com'
license          'All rights reserved'
description      'Wraps depencies on other community cookbooks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# required to run chef-solo as a user to install rvm
depends "chef_gem"
depends "rvm"
depends "apt", "= 1.7.0"
depends "git"
depends "php"
depends "mysql"
depends "apache2"
