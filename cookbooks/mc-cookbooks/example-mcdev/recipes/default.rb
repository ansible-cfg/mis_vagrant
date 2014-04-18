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
mysql_database node[:database_name] do
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

# Append configured domain to /etc/hosts file.
ruby_block "append_hosts" do
  block do
    file = Chef::Util::FileEdit.new("/etc/hosts")
    file.insert_line_if_no_match("127.0.0.1\t#{node[:domain]}", "127.0.0.1\t#{node[:domain]}")
    file.write_file
  end
end
