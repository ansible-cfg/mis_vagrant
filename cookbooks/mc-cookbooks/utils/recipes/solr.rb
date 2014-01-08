#
# Cookbook Name:: utils
# Recipe:: solr
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute

include_recipe "utils"
include_recipe "hipsnip-solr"

drupal_conf_dir = node['utils']['solr']['drupal_conf_dir']
config_dir = node['utils']['solr']['config_dir']

# Copy the config files from the drupal module and place them in the ApacheSolr
# 'conf' directory.
node['utils']['solr']['solr_config_files'].each do |config_file|
  file "#{node['solr']['home']}/#{config_dir}/#{config_file}" do
    content IO.read("#{node['utils']['solr']['drupal_module_path']}/#{drupal_conf_dir}/#{config_file}")
    notifies :restart, 'service[jetty]'
  end
end
