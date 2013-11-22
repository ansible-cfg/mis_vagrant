#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute
#

php_pear "xhprof" do
  preferred_state "beta"
  action :install
end

package "graphviz" do
  action :install
end

link "/var/www/xhprof" do
  to "/usr/share/php/xhprof_html"
end

apache_site "default" do
  enable true
end
