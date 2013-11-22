#
# Cookbook Name:: dev-tools::phpmyadmin
# Attributes:: default
#
# Copyright 2013, Mediacurrent
#
# All rights reserved - Do Not Redistribute
#

node['phpmyadmin']['home'] = '/var/www/phpmyadmin'
node['phpmyadmin']['fpm'] = false
