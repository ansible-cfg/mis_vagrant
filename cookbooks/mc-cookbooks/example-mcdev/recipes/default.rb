#
# Cookbook Name:: example-mcdev
# Recipe:: default
#
# Copyright 2013, Mediacurrent, LLC
#
# All rights reserved - Do Not Redistribute

include_recipe "memcached"

# Add memcache pecl package.
php_pear "memcache" do
  action :install
end

# Create a mysql database for homeimprovement.
mysql_database 'example_mcdev' do
  connection ({
    :host => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
  })
  action :create
end

# Create virtual host and enable site.
web_app node[:domain] do
  allow_override "All"
  docroot node[:docroot]
  server_aliases []
  server_name node[:domain]
end

###############################################################################
# Post installation/up scripts.
#
# This should almost always be the last thing you want to run.
#
# - post-installation.sh: Runs only ever once.
# - post-up.sh: Runs every time the provision scripts are ran.
#
# @todo: Do we need any other hooks?
# @todo: Should we move this into its own recipe or make this into a LWRP?
###############################################################################

# Determine if we have already run installation.
installed_tracker = "/home/vagrant/.mis_vagrant.installed"
is_installed = ::File.exists?(installed_tracker)

# The config file output.
config_file = "/tmp/mis_vagrant.config.json"

# Script paths.
post_install = "#{node[:docroot]}/sites/all/mis_vagrant/post-install.sh"
post_up = "#{node[:docroot]}/sites/all/mis_vagrant/post-up.sh"

# Run deep merge on the node config.
#
# @see http://docs.opscode.com/chef/essentials_node_object.html
# @see http://rubydoc.info/gems/chef/0.10.4/Chef/Node:to_hash
config = node.to_hash

# Write the configuration file.
file config_file do
  # @todo: Figure out a way to get the final value of the entire node object.
  #        Because right now it splits it out into default, normal, override.
  #        If not possible we need to add the specific variables that we think
  #        would be most usefule.
  content config.to_json
  mode "0644"
  owner "vagrant"
  group "vagrant"
end

# Make sure the scripts are executable.
# @todo: We probably should use resource (or maybe something else? need a little
#        bit more research for this.)
file post_up do
  mode "0755"
end

# Run the installation script only if the system hasn't already been installed.
if !is_installed
  file post_install  do
    mode "0755"
  end

  execute post_install do
    command "#{post_install} #{config_file}"
    action :run
    cwd node[:docroot]
  end

  # Lets us know if the system install has already ran.
  file installed_tracker  do
    content Time.now.getutc.inspect
    mode "0644"
  end
end

# Run the post installation script every time.
execute post_up do
  command "#{post_up} #{config_file}"
  action :run
  cwd node[:docroot]
end
