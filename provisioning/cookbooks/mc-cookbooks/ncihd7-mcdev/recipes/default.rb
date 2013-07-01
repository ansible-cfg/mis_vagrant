#
# Cookbook Name:: hi_ncihd7_mcdev
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# create a mysql database for homeimprovement
mysql_database 'hi_ncihd7_mcdev' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end
