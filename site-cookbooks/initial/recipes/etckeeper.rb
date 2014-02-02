package "etckeeper"
ruby_block "etckeeper default is git" do
  block do
    target = "/etc/etckeeper/etckeeper.conf"
    rc = Chef::Util::FileEdit.new(target)
    rc.search_file_replace_line(/^VCS="bzr"$/, 'VCS="git"')
    rc.write_file
  end
end

execute "etckeeper init" do
  command "etckeeper init"
  not_if do
    target_dir = "/etc/.git"
    ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
  end
  cwd '/etc'
end

unless node['initial']['etckeeper']['remote_repo'].nil?
  execute "add etckeeper git remote" do
    command "git remote add origin #{node['initial']['etckeeper']['remote_repo']}"
    cwd '/etc'
    not_if "cd /etc && git remote show origin -n"
  end
end

# new versions of etckeeper already have this script
cookbook_file "etckeeper hook push to repo" do
  action :create_if_missing
  mode 0755
  path '/etc/etckeeper/commit.d/99push'
  source "etckeeper-git-push"
end
