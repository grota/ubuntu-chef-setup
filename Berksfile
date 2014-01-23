site :opscode

#berks install -p cookbooks -e custom && rm -fr cookbooks/initial
cookbook 'rvm', github: 'fnichol/chef-rvm'
cookbook 'initial', path: 'site-cookbooks/initial'
cookbook 'php'

# Fricking Berkshelf does something odd with vagrant, it messes up Berkshelf.lock,
# there seem to be quite a few GH issues about this. Upgradind Berkshelf does not
# seem to fix the issue. It seems it will be fixed in Berkshelf 3.
# As a workaround we pin the deps :/
cookbook 'java', '= 1.15.4'
cookbook 'runit', '= 1.5.5'
cookbook 'yum', '= 3.0.2'
cookbook 'windows', '= 1.12.4'
cookbook 'powershell', '= 1.1.2'
