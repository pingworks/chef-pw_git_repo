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
package 'gitweb'

include_recipe 'ws-git-repo::git-daemon'
include_recipe 'ws-git-repo::git-repo'
include_recipe 'ws-git-repo::gitweb'
