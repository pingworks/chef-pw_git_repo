#
# Cookbook Name:: ws-git-repo
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
package 'git'
package 'git-daemon-run'
package 'gitweb'

node['ws-git-repo']['repos'].each do |repo|
  bash 'checkout example app' do
    user 'root'
    group 'root'
    cwd '/var/lib/git'
    code <<-EOF
    git clone --bare https://github.com/pingworks/#{repo}
    EOF
    not_if "test -d /var/lib/git/#{repo}"
  end
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
