#
# Cookbook Name:: lamp
# Recipe:: varnish
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute

include_recipe 'lamp'
include_recipe 'varnish'

raise "Only Varnish 3 is supported at this time." if node['varnish']['version'] != '3.0'
