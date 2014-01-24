# We somehow go through hoops because we need to clone a r/w repo
# so we need to setup ssh keys
target_user       = node['initial']['user']
target_user_home  = "/home/#{target_user}"
dotfiles_repo_url = node['initial']['dotfiles']['repo']
dotfiles_repo_dir = dotfiles_repo_url.split('/').last.split('.').first
dropbox_dir       = node['initial']['dropbox']['target_dir']
private_dotfile_repo_in_dropbox = "#{dropbox_dir}/git_repos/private_rcfiles"
private_clone_temp_path         = "#{target_user_home}/private_repo_clone_tmp"
chef_solo_project_root =  "#{run_context.cookbook_collection['initial'].root_dir}/../../"

def dir_not_empty(target_dir)
  ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
end

target_dir = "#{target_user_home}/#{dotfiles_repo_dir}"
if dir_not_empty target_dir
  log "#{target_dir} already exists, bailing out"
  return
end

unless dir_not_empty dropbox_dir
  Chef::Application.fatal! "Missing Dropbox dir"
end

unless ::Dir.exist?("#{target_user_home}/.ssh" )
  # create initial ssh config file
  directory "#{target_user_home}/.ssh" do
    owner target_user
    group target_user
    mode "0700"
  end
end

ssh_config = "#{target_user_home}/.ssh/config"
unless ::File.exists?(ssh_config) || ::File.symlink?(ssh_config)
  file ssh_config do
    owner target_user
    group target_user
    mode "0700"
    content <<-EOF
Host github.com
StrictHostKeyChecking no
    EOF
  end
end


# We already verified Dropbox has been setup.
# We need to clone the private repo to a temp path
# because otherwise when we clone the public repo
# git complains that the dir is not empty
execute "clone the private dotfiles repo" do
  cwd target_user_home
  command <<-BASH
  git clone #{private_dotfile_repo_in_dropbox} #{private_clone_temp_path}
  BASH
  not_if do
    target_dir = private_clone_temp_path
    private_temp_path_exists = ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
    target_dir = "#{target_user_home}/#{dotfiles_repo_dir}/private"
    final_private_repo_path = ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
    final_private_repo_path || private_temp_path_exists
  end
end

link "link to main ssh keys (pub)" do
  to "#{private_clone_temp_path}/ssh/gmail.pub"
  target_file "#{target_user_home}/.ssh/gmail.pub"
end

link "link to main ssh keys (priv)" do
  to "#{private_clone_temp_path}/ssh/gmail"
  target_file "#{target_user_home}/.ssh/gmail"
end

execute "clone the dotfiles repo" do
  # the repo will be a read/write url ending in .git
  command "git clone #{dotfiles_repo_url} #{target_user_home}/#{dotfiles_repo_dir}"
  not_if do
    target_dir = "#{target_user_home}/#{dotfiles_repo_dir}"
    ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
  end
  cwd chef_solo_project_root
end

execute "move the private repo back into the dotfiles_repo_dir" do
  command <<-BASH
  rmdir #{dotfiles_repo_dir}/private
  mv -T #{private_clone_temp_path} #{dotfiles_repo_dir}/private
  BASH
  cwd target_user_home
  not_if do
    target_dir = "#{target_user_home}/#{dotfiles_repo_dir}/private"
    ::Dir.exists?(target_dir) && (::Dir.entries(target_dir) != ['.', '..'])
  end
end

# we need to re-link the ssh keys
link "link to main ssh keys (pub)" do
  to "#{target_user_home}/#{dotfiles_repo_dir}/private/ssh/gmail.pub"
  target_file"#{target_user_home}/.ssh/gmail.pub"
end

link "link to main ssh keys (priv)" do
  to "#{target_user_home}/#{dotfiles_repo_dir}/private/ssh/gmail"
  target_file "#{target_user_home}/.ssh/gmail"
end

execute "launch dotfiles install" do
  command "./install.sh"
  cwd "#{target_user_home}#{dotfiles_repo_dir}"
end
