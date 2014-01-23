target_user = node['initial']['user']
directory "/home/#{target_user}/.ssh" do
  owner target_user
  group target_user
  mode "0700"
end
file "/home/#{target_user}/.ssh/config" do
  owner target_user
  group target_user
  mode "0700"
  content <<-EOF
Host github.com
StrictHostKeyChecking no
  EOF
end
repo_dir = node['initial']['dotfiles']['repo'].split('/').last.split('.').first

log " la dir in cui clono vale: #{repo_dir}"

execute "clone the dotfiles repo" do
  # the repo will be a read/write url ending in .git
  command <<-BASH
  git clone #{node['initial']['dotfiles']['repo']}
  cd #{repo_dir}
  BASH
  cwd "/home/#{node['initial']['user']}"
end
