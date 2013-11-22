#
# Cookbook Name:: webgrind
# Recipe:: default
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute
#

git "/var/www/webgrind" do
  repository "git://github.com/jokkedk/webgrind.git"
  reference "master"
  action :sync
end

# @todo: Set the following inside of the config.php for webgrind. For graphviz
#        to work.
# static $dotExecutable = '/usr/bin/dot';

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
