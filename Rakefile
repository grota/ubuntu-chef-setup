require 'fileutils'
include FileUtils

desc "vendor Berkshelf cookbooks into the cookbooks dir"
task :berks do |t|
  # ghetto solution, but I suck at ruby
  `berks install -p cookbooks -e custom && rm -fr cookbooks/initial`
end
