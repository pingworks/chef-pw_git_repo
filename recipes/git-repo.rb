if node['pw_git_repo']['cleanup']
  bash 'git repos cleanup' do
    user 'root'
    cwd '/var/lib/git/'
    code <<-EOH
    for dir in $(ls); do
      [ -d /var/lib/git/$dir ] && rm -rf /var/lib/git/$dir
    done
    EOH
  end
end

node['pw_git_repo']['repos'].each do |repo|
  bash "checkout #{repo[0]}" do
    user 'gitdaemon'
    group 'nogroup'
    cwd '/var/lib/git'
    code <<-EOF
    git clone --bare https://github.com/pingworks/#{repo[0]}
    touch /var/lib/git/#{repo[0]}/git-daemon-export-ok
    EOF
    not_if "test -d /var/lib/git/#{repo[0]}"
  end

  if repo[1] != ''
    bash "describe #{repo[0]}" do
      user 'gitdaemon'
      group 'nogroup'
      cwd '/var/lib/git'
      code <<-EOH
      echo "#{repo[1]}" > /var/lib/git/#{repo[0]}/description
      EOH
    end
  end

  if repo[2] != ''
    template "/var/lib/git/#{repo[0]}/hooks/post-receive" do
      source 'post-receive-hook.erb'
      owner 'gitdaemon'
      group 'nogroup'
      mode '755'
      variables({
        :jenkinsjob => repo[2]
      })
    end
  end
end

node['pw_git_repo']['repos'].each do |repo|
  bash "update #{repo[0]}" do
    user 'gitdaemon'
    group 'nogroup'
    cwd "/var/lib/git/#{repo[0]}"
    code <<-EOF
    git fetch origin master:master
    EOF
  end
end

package 'curl'

cookbook_file 'new-git-repo.sh' do
  path '/usr/local/bin/new-git-repo.sh'
  owner 'root'
  group 'root'
  mode '755'
end
