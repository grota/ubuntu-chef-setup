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

user_home = "/home/#{node['initial']['user']}"
dotfiles_repo_dir = node['initial']['dotfiles']['repo'].split('/').last.split('.').first
private_dotfile_repo_in_dropbox = "#{node['initial']['dropbox']['target_dir']}/git_repos/private_rcfiles"

#we assume Dropbox has already been setup
execute "clone the private dotfiles repo" do
  cwd user_home
  command <<-BASH
  git clone #{private_dotfile_repo_in_dropbox} #{dotfiles_repo_dir}/private
  BASH
  not_if do
    target_dir = "#{user_home}/#{dotfiles_repo_dir}/private"
    ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
  end
end

link "link to main ssh keys (pub)" do
  to "#{user_home}/#{dotfiles_repo_dir}/private/ssh/gmail.pub"
  target_file"#{user_home}/.ssh/gmail.pub"
end

link "link to main ssh keys (priv)" do
  to "#{user_home}/#{dotfiles_repo_dir}/private/ssh/gmail"
  target_file "#{user_home}/.ssh/gmail"
end

execute "clone the dotfiles repo" do
  # the repo will be a read/write url ending in .git
  command <<-BASH
  git clone #{node['initial']['dotfiles']['repo']}
  BASH
  cwd "/home/#{node['initial']['user']}"
end
