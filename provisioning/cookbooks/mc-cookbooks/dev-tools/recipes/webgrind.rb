#
# Cookbook Name:: webgrind
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "lamp"

package 'subversion'

subversion "webgrind" do
  repository "http://webgrind.googlecode.com/svn/tags/release-1.0"
  revision "HEAD"
  destination "/var/www/webgrind"
  action :sync
end

apache_site "default" do
  enable true
end
