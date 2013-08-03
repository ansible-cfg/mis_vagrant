#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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
