#
# Cookbook Name:: lamp
# Attributes:: default
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute

include_attribute "build-essential"
include_attribute "mysql::server"
include_attribute "php"

# Install build-essential.
node['build_essential']['compiletime'] = true

# MySQL settings.
default['mysql']['server_root_password'] = 'password'
default['mysql']['server_debian_password'] = 'password'
default['mysql']['server_repl_password'] = 'password'

# Sane settings for development environment.
# http://project.mediacurrent.com/mct/node/21400
node['mysql']['tunable']['max_allowed_packet'] = "64M"
node['mysql']['tunable']['max_connections'] = "40"
node['mysql']['tunable']['query_cache_limit'] = "8M"
node['mysql']['tunable']['query_cache_size'] = "64M"

# Custom PHP settings.
default['lamp']['php']['apache_conf_dir'] = '/etc/php5/apache2'
default['lamp']['php']['error_reporting'] = 'E_ALL'
default['lamp']['php']['memory_limit'] = '128M'

# APC settings.
default['lamp']['apc']['enabled'] = 1
default['lamp']['apc']['max_file_size'] = "2M"
default['lamp']['apc']['shm_segments'] = 1
default['lamp']['apc']['shm_size'] = "128M"
default['lamp']['apc']['stat'] = 1
default['lamp']['apc']['ttl'] = 14400
default['lamp']['apc']['cache_by_default'] = 1
default['lamp']['apc']['num_files_hint'] = 8000
default['lamp']['apc']['user_entries_hint'] = 8000
default['lamp']['apc']['user_ttl'] = 600
default['lamp']['apc']['gc_ttl'] = 600
default['lamp']['apc']['rfc1867'] = 1
default['lamp']['apc']['mmap_file_mask'] = "/tmp/XXXXXX"
