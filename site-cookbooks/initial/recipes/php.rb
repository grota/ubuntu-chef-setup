include_recipe "php"

%w[php5-fpm php-doc php5-pgsql php5-sqlite php5-xdebug php5-imap php5-intl php5-mcrypt php5-xhprof php5-memcached php5-curl php5-gd php5-mysql].each do |p|
  package p
end
