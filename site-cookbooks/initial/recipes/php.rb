include_recipe "php"

%w[php5-fpm php5-memcached php5-curl php5-gd php5-mysql].each do |p|
  package p
end
