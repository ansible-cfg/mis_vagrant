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

# Create virtual host and enable site.
web_app "webgrind.#{node[:domain]}" do
  cookbook "apache2"
  allow_override "All"
  docroot node['webgrind']['docroot']
  server_aliases []
  server_name "webgrind.#{node[:domain]}"
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

php_pear "Image_GraphViz" do
  preferred_state "beta"
  action :install
end
