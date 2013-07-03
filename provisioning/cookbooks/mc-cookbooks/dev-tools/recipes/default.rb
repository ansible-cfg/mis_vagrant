#
# Cookbook Name:: dev-tools
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'drush'
include_recipe 'lamp'
include_recipe 'vim'
include_recipe 'rsync'

# Install xdebug via pear.
php_pear "xdebug" do
  # Specify that xdebug.so must be loaded as a zend extension
  zend_extensions ['xdebug.so']
  action :install
  # @todo: Find all settings and make an attributes file.
  directives(
    :default_enable => node['dev-tools']['xdebug']['default_enable'],
    :profiler_append => node['dev-tools']['xdebug']['profiler_append'],
    :profiler_enable => node['dev-tools']['xdebug']['profiler_enable'],
    :profiler_enable_trigger => node['dev-tools']['xdebug']['profiler_enable_trigger'],
    :profiler_output_dir => node['dev-tools']['xdebug']['profiler_output_dir'],
    :profiler_output_name => node['dev-tools']['xdebug']['profiler_output_name'],
    :remote_autostart => node['dev-tools']['xdebug']['remote_autostart'],
    :remote_enable => node['dev-tools']['xdebug']['remote_enable'],
    :remote_handler => node['dev-tools']['xdebug']['remote_handler'],
    :remote_host => node['dev-tools']['xdebug']['remote_host'],
    :remote_port => node['dev-tools']['xdebug']['remote_port'],
    :trace_output_dir => node['dev-tools']['xdebug']['trace_output_dir']
  )
end
