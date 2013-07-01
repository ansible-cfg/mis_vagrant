#
# Cookbook Name:: drush
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "/opt/drush" do
  repository "git://drupalcode.org/project/drush.git"
  revision node['drush']['version']
  action :sync
end

link "/usr/local/bin/drush" do
  to "/opt/drush/drush"
end

php_pear "Console_Table" do
  action :install
end
