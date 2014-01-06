# Customization Guide

This guide will describe and show usage of many configuration elements for
MC Vagrant. The intended audience is system builders. If you are
looking for a way to make MC Vagrant do more stuff, you are in the right
place.

## Some background on Vagrant/Chef

Vagrant is a scriptable wrapper for Virtualbox and Chef. The **Vagrantfile**
determines the vm and manifest configuration and launches them respectively.

Configuration in vagrant/chef is managed through a combination of cookbooks,
recipes, attributes and roles. For our specific use case roles are not used
and are only mentioned because they may come up in your own documentation
searches.

**recipes**  are the basic *action* wrappers for Chef and are where the atomic
configuration and provisioning happen.

**cookbooks** are collections of related recipes packaged for reuse.

**attributes** are the instance configurable parameters for a particular
recipe. For example, there are attributes to control the memory allocated to
APC. Attributes may be present in the recipe, role and Vagrantfile and are
overridden in that order.

**roles** are collections of recipes and configuration that represent a
responsibility. You may have a "dev web server" role that includes recipes
and default attributes for apache, xhprof and other debugging tools. The
Mediacurrent Vagrant uses recipes to perform this task as recipes may be nested.

## Configuration

The platform is intended to be configured and extended in two primary ways
by the system builder:

1. Editing the Vagrantfile (located in the top-level directory)
2. Creating a project-specific cookbook (under the mc-cookbooks directory)

### Editing the Vagrantfile 

To configure the platform by enabling specific recipes, edit the *Vagrantfile*
run list. In most cases, you will only need to uncomment or comment out recipes
already listed in the recipe section of the *Vagrantfile*


        # Enable provisioning with chef solo, specifying a cookbooks path, roles
        # path, and data_bags path (all relative to this Vagrantfile), and adding
        # some recipes and/or roles.
        config.vm.provision :chef_solo do |chef|
          chef.cookbooks_path = [
            'cookbooks/mc-cookbooks',
            'cookbooks/vendor-cookbooks'
          ]

          chef.add_recipe 'lamp'
          chef.add_recipe 'dev-tools'
          #chef.add_recipe 'utils::varnish'
          #chef.add_recipe 'dev-tools::phpmyadmin'
          #chef.add_recipe 'dev-tools::xhprof'
          #chef.add_recipe 'dev-tools::webgrind'
          chef.add_recipe 'drush'
          chef.add_recipe 'example-mcdev'
          #chef.add_recipe 'utils::scripts'

          # You may also specify custom JSON attributes:
          chef.json = {}.merge(mc_settings)
        end


Details on what each recipe provides are forthcoming and listed in the
*recipes* section of this document.

### Creating Project Specific Cookbooks

The system ships with a base project cookbook named *example-mcdev*. This
cookbook performs core setup tasks that should be sufficient in many
use cases.

The following tasks are implemented:

- Capture system build information in metadata and readme files
- installs memcached for system performance
- sets up the platform mysql database named example_mcdev
- creates an apache virthost based on template web_app.conf.erb

*Important Note*: Many projects will run this cookbook to set up the
platform. Only create a new project specific cookbook if your project
requires additional customization (running multiple databases, virthosts,
etc.); as, the project team will be responsible for maintaining it.

Chef cookbooks are written in ruby and consist of attributes, templates,
and recipes. You will notice that there are directories named to match. The
default.rb file is the default execution entry point for a given cookbook.
Beyond that, please refer to other sources better suited for beginning
development with chef.

# Recipes

* dev-tools

    Installs drush, rsync, and vim.

    - dev-tools::phpmyadmin
    - dev-tools::webgrind

      **Not compatiable with** ```dev-tools::xhprof```

    - dev-tools::xhprof

      **Not compatiable with** ```dev-tools::webgrind```

* drush

* example-mcdev

    The base project-specific cookbook.

* lamp

    A fully functioning LAMP stack.

* utils

    Various utilities.

    - scripts
      Runs a set of scripts ```post-install.sh``` and ```post-up.sh``` from your
      projects docroot.
    - varnish

**Don't forget to update your mis_vagrant branch and project repo.**

