# let's just install apache2 without using the community cookbook,
# there are too many incompatibilities between apache 2.2 and 2.4
# We need to copy apache2's cookbook definition in order not to include
# the default recipe of apache which contains a default template
#config file that is not compatible with apache 2.4
%w[apache2 libapache2-mod-fcgid].each do |p|
  package p
end

apache_module 'fcgid' do
  enable false
end

apache_module 'proxy'
apache_module 'proxy_fcgi'

service "apache2" do
  action :nothing
end

