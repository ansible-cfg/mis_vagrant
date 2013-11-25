#
# Cookbook Name:: utils
# Recipe:: varnish
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute

include_recipe "utils"

raise "Only Varnish 3 is supported at this time." if node['varnish']['version'] != '3.0'

package "varnish"

# Create the secure key file if there is a non-secure secret set.
if node['varnish']['secret-non_secure']
  file "#{node['varnish']['secret_file']}" do
    # T new line is required because it is normally created there by the uuidgen
    # which generates this secret file. The Drupal module also accomodates this
    # in its interactions automatically.
    #
    # @see http://michaelphipps.com/how-create-varnish-secret-file
    # @see https://drupal.org/comment/5872422#comment-5872422
    content "#{node['varnish']['secret-non_secure']}\n"
    owner "root"
    group "root"
    mode 0600
    action :create
  end
end

template "#{node['varnish']['dir']}/#{node['varnish']['vcl_conf']}" do
  source node['varnish']['vcl_source']
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[varnish]"
end

template node['varnish']['default'] do
  source "custom-default.erb"
  cookbook "varnish"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[varnish]"
end

service "varnish" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "varnishlog" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end
