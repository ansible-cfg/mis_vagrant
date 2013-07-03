# Description
# Requirements

* Vagrant 1.2.2

# Installation

1. Retrieve the vendor recipes.
    $ git submodule init
    $ git submodule update
2. [Install Vagrant](http://docs.vagrantup.com/v2/installation/index.html)
3. Start up vagrant.
    $ vagrant up
4. ssh into your new pre-configured development environment. (Optional)
    vagrant ssh

Changes may be made in the docroot (usually the site's domain name) and they will
be reflected on the dev site.

# Recipes

* dev-tools
* drush
* lamp
