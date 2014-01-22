#
# Cookbook Name:: utils
# Recipe:: scripts
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute

###############################################################################
# Post installation/up scripts.
#
# This should almost always be the last thing you want to run.
#
# - post-installation.sh: Runs only ever once.
# - post-up.sh: Runs every time the provision scripts are ran.
#
# @todo: Do we need any other hooks?
###############################################################################

# Determines if we should throw an error because none of the scripts were available
# to run.
scripts_ran = false

# Determine if we have already run installation.
installed_tracker = "/home/vagrant/.mc-utils-scripts.installed"
is_installed = ::File.exists?(installed_tracker)

# The config file output.
config_file = "/tmp/mc-utils-scripts.config.json"

# Script paths.
scripts_path = (!node[:script_paths].nil?) ? node[:script_paths] : node['utils']['scripts']['script_paths']

# Default is: sites/all/mis_vagrant
post_install = "#{node[:docroot]}/#{scripts_path}/post-install.sh"
post_up = "#{node[:docroot]}/#{scripts_path}/post-up.sh"

# Run deep merge on the node config.
#
# @see http://docs.opscode.com/chef/essentials_node_object.html
# @see http://rubydoc.info/gems/chef/0.10.4/Chef/Node:to_hash
config = node.to_hash

# Write the configuration file.
file config_file do
  content config.to_json
  mode "0644"
  owner "vagrant"
  group "vagrant"
end

# Run the installation script only if the system hasn't already been installed.
if !is_installed and ::File.exists?(post_install) and ::File.executable?(post_install)
  file post_install  do
    mode "0755"
  end

  execute post_install do
    command "#{post_install} #{config_file}"
    action :run
    cwd node[:docroot]
    user 'vagrant'
  end

  # Lets us know if the system install has already ran.
  file installed_tracker  do
    content Time.now.getutc.inspect
    mode "0644"
  end

  scripts_ran = true
end

if ::File.exists?(post_up) and ::File.executable?(post_up)
  file post_up do
    mode "0755"
  end

  # Run the post installation script every time.
  execute post_up do
    command "#{post_up} #{config_file}"
    action :run
    cwd node[:docroot]
    user 'vagrant'
  end

  scripts_ran = true
end

# @todo: Figure out a clean way to allow for the POST install scripts to tell
#        us if it failed...
if !scripts_ran
  raise "No scripts where ran. Either create a 'post-install.sh' or 'post-up.sh' in '#{node[:docroot]}/#{scripts_path}' or disable this recipe 'utils::scripts'."
end
