# Dropbox recipe, it has an initial rsync phase so that it's faster

if node['initial']['dropbox'].nil?
  Chef::Application.fatal! "You must set the node['initial']['dropbox'] attribute in chef-solo mode."
end

missing_attrs = %w[
source_dir
target_dir
arch
version
].select { |attr| node['initial']['dropbox'][attr].nil? }.map { |attr| %Q{node['initial']['dropbox']['#{attr}']} }
unless missing_attrs.empty?
  Chef::Application.fatal! "You must set #{missing_attrs.join(', ')}."
end

chef_solo_project_root = "#{run_context.cookbook_collection['initial'].root_dir}/../../"
execute "prefill dropbox dir from backup" do
  command %Q{rsync -a #{node['initial']['dropbox']['source_dir']}/ #{node['initial']['dropbox']['target_dir']}/}
  cwd chef_solo_project_root
  not_if do
    target_dir = "#{node['initial']['dropbox']['target_dir']}"
    target_not_empty = ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
    source_dir = "#{node['initial']['dropbox']['source_dir']}"
    source_not_empty_absolute = ::Dir.exists?(source_dir) && (::Dir.entries(source_dir) != ['.', '..'])
    source_dir = "#{chef_solo_project_root}/#{node['initial']['dropbox']['source_dir']}"
    source_not_empty_rel_to_proj = ::Dir.exists?(source_dir) && (::Dir.entries(source_dir) != ['.', '..'])
    target_not_empty || !(source_not_empty_absolute || source_not_empty_rel_to_proj)
  end
end

dropbox_arch    = node['initial']['dropbox']['arch']
dropbox_version = node['initial']['dropbox']['version']
dropbox_deb_file = "#{Chef::Config[:file_cache_path]}/dropbox_#{dropbox_version}_#{dropbox_arch}.deb"
remote_file "dropbox deb file" do
  path dropbox_deb_file
  source "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_#{dropbox_version}_#{dropbox_arch}.deb"
  action :create_if_missing
end
dpkg_package dropbox_deb_file
