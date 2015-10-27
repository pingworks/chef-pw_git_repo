package 'highlight'

# Theming
cookbook_file '/usr/share/gitweb/static/gitweb.css' do
  source 'gitweb.css'
  owner 'root'
  group 'root'
  mode 00644
end

cookbook_file '/usr/share/gitweb/static/git-favicon.png' do
  source 'git-favicon.png'
  owner 'root'
  group 'root'
  mode 00644
end

cookbook_file '/usr/share/gitweb/static/git-logo.png' do
  source 'git-logo.png'
  owner 'root'
  group 'root'
  mode 00644
end

template '/etc/gitweb.conf' do
  source 'gitweb-conf.erb'
  owner 'root'
  group 'root'
  mode 00644
end

cookbook_file "apache-conf-gitweb.conf" do
  path '/etc/apache2/conf-available/gitweb.conf'
  owner "root"
  group "root"
  mode '644'
end

bash 'enable_apache_gitweb_conf' do
  code 'a2enconf gitweb'
end

bash 'enable_apache_cgi' do
  code 'a2enmod cgi'
end

bash 'apache2_restart' do
  code 'service apache2 restart'
end
