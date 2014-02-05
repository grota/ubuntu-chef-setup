cookbook_file "sudoers config for user grota" do
  action :create_if_missing
  mode 0440
  path '/etc/sudoers.d/grota'
  source "sudoers_grota"
end

