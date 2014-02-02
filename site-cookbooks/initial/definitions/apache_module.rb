# copied from apache2's definition but without the include_recipe
define :apache_module, :enable => true, :conf => false do

  params[:filename]    = params[:filename] || "mod_#{params[:name]}.so"
  params[:module_path] = params[:module_path] || "#{node['apache']['libexecdir']}/#{params[:filename]}"
  params[:identifier]  = params[:identifier] || "#{params[:name]}_module"

  apache_conf params[:name] if params[:conf]

  if platform_family?('rhel', 'fedora', 'arch', 'suse', 'freebsd')
    file "#{node['apache']['dir']}/mods-available/#{params[:name]}.load" do
      content "LoadModule #{params[:identifier]} #{params[:module_path]}\n"
      mode    '0644'
    end
  end

  if params[:enable]
    execute "a2enmod #{params[:name]}" do
      command "/usr/sbin/a2enmod #{params[:name]}"
      notifies :restart, 'service[apache2]'
      not_if do
        ::File.symlink?("#{node['apache']['dir']}/mods-enabled/#{params[:name]}.load") &&
        (::File.exists?("#{node['apache']['dir']}/mods-available/#{params[:name]}.conf") ? ::File.symlink?("#{node['apache']['dir']}/mods-enabled/#{params[:name]}.conf") : true)
      end
    end
  else
    execute "a2dismod #{params[:name]}" do
      command "/usr/sbin/a2dismod #{params[:name]}"
      notifies :restart, 'service[apache2]'
      only_if { ::File.symlink?("#{node['apache']['dir']}/mods-enabled/#{params[:name]}.load") }
    end
  end
end

