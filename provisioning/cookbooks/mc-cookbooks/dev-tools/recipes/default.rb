#
# Cookbook Name:: dev-tools
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "lamp"

# Install xdebug via pear.
php_pear "xdebug" do
  # Specify that xdebug.so must be loaded as a zend extension
  zend_extensions ['xdebug.so']
  action :install
  # @todo: Find all settings and make an attributes file.
  directives(
    :default_enable => 1,
    :remote_enable => 1,
    :remote_handler => "dbgp",
    :remote_host => "localhost",
    :remote_port => 9000,
    :remote_autostart => 0
  )
end
