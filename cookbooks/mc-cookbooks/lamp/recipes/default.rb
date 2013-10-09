#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute

include_recipe 'apt'
# Must be above mysql to install make.
include_recipe 'build-essential'
include_recipe 'build-essential::debian'
include_recipe 'apache2'
include_recipe 'cron'
include_recipe 'database'
include_recipe 'mysql'
include_recipe 'openssl'
include_recipe 'php'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'
include_recipe 'database::mysql'
include_recipe 'mysql::client'
include_recipe 'mysql::ruby'
include_recipe 'mysql::server'
include_recipe 'php::module_apc'
include_recipe 'php::module_gd'
include_recipe 'php::module_mysql'

template "#{node['lamp']['php']['apache_conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

# Add uploadprogress pecl package.
php_pear "uploadprogress" do
  action :install
end
