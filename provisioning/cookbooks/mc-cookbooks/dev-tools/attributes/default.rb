#
# Cookbook Name:: dev-tools
# Attributes:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default['dev-tools']['xdebug']['default_enable']  = 1
default['dev-tools']['xdebug']['profiler_append']  = 0
default['dev-tools']['xdebug']['profiler_enable']  = 0
default['dev-tools']['xdebug']['profiler_enable_trigger'] = 1
default['dev-tools']['xdebug']['profiler_output_dir']  = '/tmp'
default['dev-tools']['xdebug']['profiler_output_name']  = 'cachegrind.out.%t-%s'
default['dev-tools']['xdebug']['remote_autostart'] = 0
default['dev-tools']['xdebug']['remote_enable']  = 1
default['dev-tools']['xdebug']['remote_handler']  = 'dbgp'
default['dev-tools']['xdebug']['remote_host']  = '127.0.0.1'
default['dev-tools']['xdebug']['remote_port']  = 9000
default['dev-tools']['xdebug']['trace_output_dir']  = '/tmp'
