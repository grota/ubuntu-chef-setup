# there are too many incompatibilities between apache 2.2 and 2.4
# let's just install apache2 without using the community cookbook's
# default recipe.
#
# in definitions/*:
# We need to copy apache2's cookbook definitions in order not to include
# the default recipe of apache which contains a default template
# config file that is not compatible with apache 2.4
#
# in templates/*:
# the tpl for the php_web_app definition which is very similar to the
# tpl for web_app in apache2's cookbook, but I removed some rewrite statements
# and included the ProxyPassMatch for the php
%w[apache2 libapache2-mod-fcgid].each do |p|
  package p
end

# We don't need an apache module which spawns/manages cgi processes, php-fpm alreay does that
apache_module 'fcgid' do
  enable false
end
# new apache proxy modules instead of mod_fastcgi
apache_module 'proxy'
apache_module 'proxy_fcgi'

apache_module 'rewrite'
apache_module 'status'
# Apache 2.4 introduces a new auth module, http://httpd.apache.org/docs/2.4/mod/mod_authz_host.html
# See for more information http://httpd.apache.org/docs/2.4/upgrading.html
# But for now I just enable the old compat module
apache_module 'access_compat'

#required by our definition apache_module
#which is copied over from apache2's cookbook
#and notifies the service
service "apache2" do
  action :enable
end

php_web_app 'first-test' do
  docroot '/var/www/t1'
  server_name 'vagrant_privnetwork'
  server_aliases []
end
