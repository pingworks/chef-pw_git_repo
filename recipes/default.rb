#
# Cookbook Name:: pw_git_repo
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
package 'git'
package 'gitweb'

include_recipe 'pw_git_repo::git-daemon'
include_recipe 'pw_git_repo::git-repo'
include_recipe 'pw_git_repo::gitweb'
