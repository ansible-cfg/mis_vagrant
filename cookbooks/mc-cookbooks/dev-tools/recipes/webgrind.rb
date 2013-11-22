#
# Cookbook Name:: webgrind
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "git"
include_recipe "lamp"

git "#{node['webgrind']['docroot']}" do
  repository "git://github.com/jokkedk/webgrind.git"
  reference "master"
  action :sync
end

# Custom settings for webgrind's config.php to make graphviz work.
template "#{node['webgrind']['docroot']}/config.php" do
  source "config.php.erb"
  owner "root"
  group "root"
  mode "0644"
end

package "graphviz" do
  action :install
end

apache_site "default" do
  enable true
end

php_pear "Image_GraphViz" do
  preferred_state "beta"
  action :install
end
