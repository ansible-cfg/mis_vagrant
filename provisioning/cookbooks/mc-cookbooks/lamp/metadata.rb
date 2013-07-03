name             'lamp'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures drush'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          'apt'
depends          'build-essential'
depends          'build-essential::debian'
depends          'apache2'
depends          'cron'
depends          'database'
depends          'mysql'
depends          'openssl'
depends          'php'
depends          'apache2::mod_php5'
depends          'apache2::mod_rewrite'
depends          'database::mysql'
depends          'mysql::client'
# Needed since we are using the database recipe.
depends          'mysql::ruby'
depends          'mysql::server'
depends          'php::module_apc'
# @todo: Would we rather add gd to a drupal specific one?
depends          'php::gd'
depends          'php::module_mysql'
