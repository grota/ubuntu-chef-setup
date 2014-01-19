# sudo chef-solo -c solo.rb -j dna.json
# Project is not DRY, the run list is repeated in dna.json
current_dir = File.expand_path(File.dirname(__FILE__))
cookbook_path [current_dir+"/cookbooks", current_dir+"/site-cookbooks"]
log_level :info
verbose_logging    false
#file_cache_path    "/var/chef/cache"
#file_backup_path   "/var/chef/backup"
