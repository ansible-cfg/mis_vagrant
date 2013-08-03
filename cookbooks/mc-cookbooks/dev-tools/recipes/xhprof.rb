#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "lamp"

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
