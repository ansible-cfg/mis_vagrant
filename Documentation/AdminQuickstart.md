# Admin Quickstart Guide

## Introduction

 The vagrant build is designed to be added to an existing project and may sit alongside or live within the project repository (as a git submodule). Which method makes the most sense depends on project needs and architecture.

## Installation

Follow all instructions in the User quickstart to ensure that you have all required dependencies.

1. Create (or clone locally) your project repo.

2. Once your project repo is created, you have two options:
  - Make mis_vagrant a submodule of your project's repo (As long as the docroot
    is not the root of your repo.) Via ```[myrepo]$ git submodule add git@bitbucket.org:mediacurrent/mis_vagrant.git```
  - Clone the mc_vagrant project into a directory parallel to your repo.
  ```[myrepo]$ cd .. && git clone git clone git@bitbucket.org:mediacurrent/mis_vagrant.git```

3. Change into the mis_vagrant repo and create a new branch ```git checkout -b project/client--project```

4. Modify the Vagrantfile to match the desired server configuration (more detail below).

5. Modify the Vagrantfile mc_settings to specify the docroot for your project relative to the Vagrantfile.

  ```
    mc_settings = {
      :domain       => 'example.mcdev',
      :docroot      => '/home/vagrant/docroot',
      :host_docroot => '../docroot'
    }
  ```

  *host_docroot refers to the location of the project docroot relative to this file.*

6. Add the domain/IP for this installation to the devops google doc [here](https://docs.google.com/a/mediacurrent.com/spreadsheet/ccc?key=0AuLhQk3Txl-JdFNGOGNEV0twcUlwR09tWkU1NVNMZnc&usp=sharing). Select the next IP in the current range and add to the proper column in the spreadsheet. Use this IP in step 7. The /etc/hosts entry will be populated for you. If you do not have access to edit this spreadsheet, a member of DevOps can help you.

7. Provide instructions to add the "domain" to their /etc/hosts file that matches the IP as specified by the line below in the Vagrantfile

  ```
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: "192.168.50.4"
  ```

8. Create or add to existing drushrc file at docroot/sites/all/drush/[project shortname].aliases.drushrc.php with the following

  ```
  // vagrant local development vm
  $aliases['mcdev'] = array(
    'uri' => 'example.mcdev',
    'root' => '/home/vagrant/docroot',
    'remote-host' => 'example.mcdev',
    'path-aliases' => array(
    '%drush-script' => '/usr/local/bin/drush',
    ),
    'remote-user' => 'vagrant',
  );
  ```

9. Check in your changes and push into your branch.

10. (Only necessary if you chose to use a submodule) Add the mis_vagrant
    directory and check in your projects repo. This will need to be done anytime
    anytime a change is made to mis_vagrant as the submodule keeps track of a
    sha hash that the submodule should be pointing to.

## Bending Vagrant to your will

### Some background on Vagrant/Chef

Vagrant is a scriptable wrapper for Virtualbox and Chef. The **Vagrantfile** determines the vm and manifest configuration and launches them respectively.

Configuration in vagrant/chef is managed through a combination of cookbooks, recipes, attributes and roles. For our specific use case roles are not used and are only mentioned because they may come up in your own documentation searches.

**recipes**  are the basic *action* wrappers for Chef and are where the atomic configuration and provisioning happen.

**cookbooks** are collections of related recipes packaged for reuse.

**attributes** are the instance configurable parameters for a particular recipe. For example, there are attributes to control the memory allocated to APC. Attributes may be present in the recipe, role and Vagrantfile and are overridden in that order.

**roles** are collections of recipes and configuration that represent a responsibility. You may have a "dev web server" role that includes recipes and default attributes for apache, xhprof and other debugging tools. The Mediacurrent Vagrant uses recipes to perform this task as recipes may be nested.

### Configuration

To configure the platform for your specific needs, compose your *Vagrantfile* run list.
```
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
```

Details on what each recipe provides are forthcoming.

# Recipes

* dev-tools

    Installs drush, rsync, and vim.

    - dev-tools::phpmyadmin
    - dev-tools::webgrind

      **Not compatiable with** ```dev-tools::xhprof```

    - dev-tools::xhprof

      **Not compatiable with** ```dev-tools::webgrind```

* drush
* lamp

    A fully functioning LAMP stack.

* utils

  Various utilities.

  - scripts

    Runs a set of scripts ```post-install.sh``` and ```post-up.sh``` from your
    projects docroot.

  - varnish

Once you are satisfied with your build, create a branch within the mc_vagrant project for your own and commit the changes there. When that is complete, add the submodule to your project repo or provide instructions on where to place it relative to the project root.

## Troubleshooting

