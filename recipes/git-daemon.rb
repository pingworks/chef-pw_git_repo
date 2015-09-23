package 'git-daemon-sysvinit'

cookbook_file 'default-git-daemon' do
  path '/etc/default/git-daemon'
  owner 'root'
  group 'root'
  mode '644'
end

service 'git-daemon' do
  supports status: true, restart: true, reload: true
  action  [:enable, :start]
end

directory '/var/lib/git' do
  owner 'gitdaemon'
  group 'nogroup'
  mode '755'
end
