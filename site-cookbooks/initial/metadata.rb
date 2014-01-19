name             'initial custom cookbook'
maintainer       'Giuseppe Rota'
maintainer_email 'rota.giuseppe@gmail.com'
license          'All rights reserved'
description      'Wraps depencies on other community cookbooks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apt"
depends "git"
