node['ws-git-repo']['repos'].each do |repo|
  bash "checkout #{repo}" do
    user 'gitdaemon'
    group 'nogroup'
    cwd '/var/lib/git'
    code <<-EOF
    git clone --bare https://github.com/pingworks/#{repo}
    touch /var/lib/git/#{repo}/git-daemon-export-ok
    EOF
    not_if "test -d /var/lib/git/#{repo}"
  end
end

template '/var/lib/git/phonebook.git/hooks/post-receive' do
  source 'post-receive-hook.erb'
  owner 'gitdaemon'
  group 'nogroup'
  mode '755'
end

package 'curl'

cookbook_file 'new-git-repo.sh' do
  path '/usr/local/bin/new-git-repo.sh'
  owner 'root'
  group 'root'
  mode '755'
end
