#
# Cookbook Name:: drush
# Attributes:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install build-essential.
default['build_essential']['compiletime'] = true

# Mysql passwords.
default['mysql']['server_root_password'] = 'password'
default['mysql']['server_debian_password'] = 'password'
default['mysql']['server_repl_password'] = 'password'
