#
# Cookbook Name:: lamp
# Attributes:: varnish
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute

include_attribute "varnish"

default['varnish']['version'] = '3.0'
default['varnish']['vcl_source'] = "varnish-3.erb"
default['varnish']['vcl_cookbook'] = 'lamp'

default['varnish']['backend_host'] = '127.0.0.1'
default['varnish']['backend_port'] = '80'
default['varnish']['secret_file'] = ''
