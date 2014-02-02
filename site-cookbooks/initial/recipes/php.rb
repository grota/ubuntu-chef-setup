include_recipe "php"

%w[php5-fpm php-doc php5-pgsql php5-sqlite php5-xdebug php5-imap php5-intl php5-mcrypt php5-xhprof php5-memcached php5-curl php5-gd php5-mysql].each do |p|
  package p
end

# fpm sysv init script bails out when under upstart.
# jesus...
service 'php5-fpm' do
  action :start
  start_command 'start php5-fpm'
  stop_command 'stop php5-fpm'
  restart_command 'stop php5-fpm && start php5-fpm'
  status_command 'status php5-fpm'
end

# We need to make fpm listen on a tcp (and not a unix) socket because
# mod_proxy_fcgi does not support a unix socket yet.
# We still need to deal with other fpm pools
ruby_block "change the default php-fpm pool to use a tcp socket (127.0.0.1:9000)" do
  block do
    target = "/etc/php5/fpm/pool.d/www.conf"
    rc = Chef::Util::FileEdit.new(target)
    rc.search_file_replace_line(/^listen = \/var\/run\/php5-fpm.sock$/, "listen = 127.0.0.1:9000")
    rc.write_file
  end
  notifies :restart, 'service[php5-fpm]'
end
