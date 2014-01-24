# sudo chef-solo -c solo.rb
json_attribs 'sudo.json'
current_dir = File.expand_path(File.dirname(__FILE__))
cookbook_path [current_dir+"/cookbooks", current_dir+"/site-cookbooks"]
log_level :info
verbose_logging    false
#file_cache_path    "/tmp/chef/cache"
#file_backup_path   "/tmp/chef/backup"
