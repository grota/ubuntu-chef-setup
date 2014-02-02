# copied from apache2's definition but without the include_recipe
# I also removed the extra apache modules
define :php_web_app, :template => 'php_web_app.conf.erb', :enable => true do

  application_name = params[:name]

  template "#{node['apache']['dir']}/sites-available/#{application_name}.conf" do
    source   params[:template]
    owner    'root'
    group    node['apache']['root_group']
    mode     '0644'
    cookbook params[:cookbook] if params[:cookbook]
    variables(
      :application_name => application_name,
      :params           => params
    )
    if ::File.exists?("#{node['apache']['dir']}/sites-enabled/#{application_name}.conf")
      notifies :reload, 'service[apache2]'
    end
  end

  site_enabled = params[:enable]
  apache_site "#{params[:name]}.conf" do
    enable site_enabled
  end
end
