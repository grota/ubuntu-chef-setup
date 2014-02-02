# copied from apache2's definition but without the include_recipe
define :apache_site, :enable => true do
  if params[:enable]
    execute "a2ensite #{params[:name]}" do
      command "/usr/sbin/a2ensite #{params[:name]}"
      notifies :restart, 'service[apache2]'
      not_if do
        ::File.symlink?("#{node['apache']['dir']}/sites-enabled/#{params[:name]}") ||
        ::File.symlink?("#{node['apache']['dir']}/sites-enabled/000-#{params[:name]}")
      end
      only_if { ::File.exists?("#{node['apache']['dir']}/sites-available/#{params[:name]}") }
    end
  else
    execute "a2dissite #{params[:name]}" do
      command "/usr/sbin/a2dissite #{params[:name]}"
      notifies :restart, 'service[apache2]'
      only_if do
        ::File.symlink?("#{node['apache']['dir']}/sites-enabled/#{params[:name]}") ||
        ::File.symlink?("#{node['apache']['dir']}/sites-enabled/000-#{params[:name]}")
      end
    end
  end
end

