
if node['initial'].nil?
  Chef::Application.fatal! "You must set the node['initial'] attribute in chef-solo mode."
end
missing_attrs = %w[
dropbox_source_dir
dropbox_target_dir
].select { |attr| node['initial'][attr].nil? }.map { |attr| %Q{node['initial']['#{attr}']} }
unless missing_attrs.empty?
  Chef::Application.fatal! "You must set #{missing_attrs.join(', ')}."
end

execute "sync dropbox before from backup" do
  command %Q{rsync -a #{node['initial']['dropbox_source_dir']}/ #{node['initial']['dropbox_target_dir']}/}
  cwd "#{run_context.cookbook_collection['initial'].root_dir}/../../"
  # this guard is fragile
  not_if { ::File.exists?("#{node['initial']['dropbox_target_dir']}/Docs/postfix")  }
end
