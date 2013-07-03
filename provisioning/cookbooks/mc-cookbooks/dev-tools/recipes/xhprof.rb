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
