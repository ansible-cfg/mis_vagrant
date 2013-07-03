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

git "/var/www/webgrind" do
  repository "git://github.com/jokkedk/webgrind.git"
  reference "master"
  action :sync
end

apache_site "default" do
  enable true
end
