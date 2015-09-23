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
