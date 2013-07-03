#
# Cookbook Name:: phpmyadmin
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node.default['phpmyadmin']['fpm'] = false

include_recipe "lamp"
include_recipe "phpmyadmin"

phpmyadmin_db 'Test DB' do
    host '127.0.0.1'
    port 3306
    username 'root'
    password 'password'
    hide_dbs %w{ information_schema mysql phpmyadmin performance_schema }
end

apache_site "default" do
  enable true
end
