# MIS Example
## Setting up a local [Vagrant](http://vagrantup.com) environment

The Mediacurrent local Vagrant is based upon work from [DrupalVM](https://www.drupalvm.com/).

### Download and install VirtualBox (>= 5.x) from [here](https://www.virtualbox.org/wiki/Downloads). To check if you have this on your Terminal use the following command:

`vboxmanage -v`

That should return your version number. Most recently tested version to be working is 5.1.12*.

### Download and install Vagrant (>= 1.8.6) from [here](https://www.vagrantup.com/downloads.html). To check what version you may have you can oepn Terminal and use the following command:

`vagrant --version`

Note: Vagrant version 1.8.7 caused issues and should be avoided. Most  recently tested version to be working is 1.9.1.

### Install Vagrant Host Manager Plugin:

This plugin will automatically update your /etc/hosts on your machine so that IP addresses do not have to be mapped manually. You'll only have to install this once.
`vagrant plugin install vagrant-hostsupdater`

To verify if you have the plugin you can run:

`vagrant plugin list`

If you have the plugin you will see it in the returned list.

### Add the vagrant ssh key to your .ssh directory

Normally this will already be installed. This will allow you to SSH into your vagrant machine without a password. If you already have this file then the command will return a notice that the file exists. This is ok.

```bash
ln -s ~/.vagrant.d/insecure_private_key ~/.ssh/vagrant_insecure_private_key
chmod 600 ~/.ssh/vagrant_insecure_private_key
```

These commands will add a symlink to your default .ssh folder. The chmod command will change the permissions to appropriate permissions. To validate this worked properly run the following command:

`ls -lah ~/.ssh/vagrant_insecure_private_key`

The output of this should look like the following:

```bash
ls -lah ~/.ssh/vagrant_insecure_private_key
lrwxr-xr-x  1 username  staff    47B Mar  8  2014 /Users/username/.ssh/vagrant_insecure_private_key -> /Users/username/.vagrant.d/insecure_private_key
```



### Add mcdev top level domain to your ssh config by editing [home]/.ssh/config and adding the following lines: Note: This should only need to be done once. You may already have this in your ~/.ssh/config file:

```bash
Host *.mcdev
  ForwardAgent yes
  IdentityFile ~/.ssh/vagrant_insecure_private_key
  User vagrant
```

This will allow you to ssh into any Vagrant machine from anywhere on your machine.

### Clone these repos into the directory of your choice. Note: This will be where your site is located on your machine. The URL below will be the URL for your specific project's vagrant.
- `git clone git@bitbucket.org:mediacurrent/mis_vagrant_example.git`

### Initialize the submodules to get the mis_example codebase. These commands will retrieve any additional code needed for building your site including the git repository for the core drupal files (usually in a separate Bitbucket location).
- `cd mis_vagrant_example`
- `git submodule init && git submodule update --remote`
- `git submodule foreach git checkout develop`

The Example codebase ( git@bitbucket.org:mediacurrent/mis_example.git_)
is now installed in the "mis_example" directory.

### Start the box from the `mis_vagrant_example` directory
- `vagrant up`
*You may be prompted for your sudo password for the NFS mount*

At this point you should have a working vagrant but not a working site. To obtain a working site you'll need to install a site profile, or use a database backup from a server to install. Since this varies from project to project reference your project specific repository or Confluence space for details on site and database installation.

## Global Vagrant Helpers

By using the standard MC vagrant you get access to some additional tools outlined below.

### Generate a login link

Login links can be generated via Drush. To do this you'll need to navigate to the docroot that Drupal is located in and use the Drush alias (@example.mcdev) provided by your project. The ULI command will return a URL you can use in your browser to login to the site.

- `cd path/to/docroot`
- `drush @example.mcdev uli`
  or
- `vagrant ssh`
- `cd /home/vagrant/docroot/sites/example.mcdev`
- `drush uli`

- Log out of the vagrant server (ctrl-d usually works well)

### Run the Coding Standards tests.

*NOTE* There will be not tests run until modules are in the "sites/all/modules/custom" directory.

Drupal 7:
- `vagrant ssh -c "/vagrant/tests/code-sniffer.sh /home/vagrant/docroot"`

Drupal 8:
- `vagrant ssh -c "/vagrant/tests/code-sniffer.sh /home/vagrant/docroot/web"`

### Run the Security Review tests.
(Drupal 7 only)

- `vagrant ssh -c "/vagrant/tests/security-review.sh example.mcdev /home/vagrant/docroot"`

### Run the Accessibility tests.

- `vagrant ssh -c "/vagrant/tests/pa11y/pa11y-review.sh example.mcdev"`

### Run the BDD system tests.

- `vagrant ssh -c "/vagrant/tests/behat/behat-run.sh http://example.mcdev"`
- To run individual tests or further configuration. See tests/behat/README.md

## [Documentation](Documentation)

* [UserQuickstart](Documentation/UserQuickstart.md)
* [AdminQuickstart](Documentation/AdminQuickstart.md)
* [Customization](Documentation/Customization.md)
* [FAQ](Documentation/FAQ.md)
* [Gitflow](Documentation/Gitflow.md)

![Drupal VM Logo](https://raw.githubusercontent.com/geerlingguy/drupal-vm/master/docs/images/drupal-vm-logo.png)

[![Build Status](https://travis-ci.org/geerlingguy/drupal-vm.svg?branch=master)](https://travis-ci.org/geerlingguy/drupal-vm) [![Documentation Status](https://readthedocs.org/projects/drupal-vm/badge/?version=latest)](http://docs.drupalvm.com) [![Packagist](https://img.shields.io/packagist/v/geerlingguy/drupal-vm.svg)](https://packagist.org/packages/geerlingguy/drupal-vm)

[Drupal VM](https://www.drupalvm.com/) is A VM for local Drupal development, built with Vagrant + Ansible.

This project aims to make spinning up a simple local Drupal test/development environment incredibly quick and easy, and to introduce new developers to the wonderful world of Drupal development on local virtual machines (instead of crufty old MAMP/WAMP-based development).

It will install the following on an Ubuntu 16.04 (by default) linux VM:

  - Apache 2.4.x (or Nginx)
  - PHP 7.1.x (configurable)
  - MySQL 5.7.x (or MariaDB, or PostgreSQL)
  - Drupal 7 or 8
  - Optional:
    - Drupal Console
    - Drush
    - Varnish 4.x (configurable)
    - Apache Solr 4.10.x (configurable)
    - Elasticsearch
    - Node.js 0.12 (configurable)
    - Selenium, for testing your sites via Behat
    - Ruby
    - Memcached
    - Redis
    - SQLite
    - Blackfire, XHProf, or Tideways for profiling your code
    - XDebug, for debugging your code
    - Adminer, for accessing databases directly
    - Pimp my Log, for easy viewing of log files
    - MailHog, for catching and debugging email

It should take 5-10 minutes to build or rebuild the VM from scratch on a decent broadband connection.

Please read through the rest of this README and the [Drupal VM documentation](http://docs.drupalvm.com/) for help getting Drupal VM configured and integrated with your development workflow.

## Documentation

Full Drupal VM documentation is available at http://docs.drupalvm.com/

## Customizing the VM

There are a couple places where you can customize the VM for your needs:

  - `config.yml`: Override any of the default VM configuration from `default.config.yml`; customize almost any aspect of any software installed in the VM (more about [overriding configurations](http://docs.drupalvm.com/en/latest/other/overriding-configurations/).
  - `drupal.composer.json` or `drupal.make.yml`: Contains configuration for the Drupal core version, modules, and patches that will be downloaded on Drupal's initial installation (you can build using Composer, Drush make, or your own codebase).

If you want to switch from Drupal 8 (default) to Drupal 7 on the initial install, do the following:

  1. Switch to using a [Drush Make file](http://docs.drupalvm.com/en/latest/deployment/drush-make/).
  1. Update the Drupal `version` and `core` inside your `drupal.make.yml` file.
  2. Set `drupal_major_version: 7` inside `config.yml`.

## Quick Start Guide

This Quick Start Guide will help you quickly build a Drupal 8 site on the Drupal VM using Composer with `drupal-project`. You can also use Drupal VM with [Composer](http://docs.drupalvm.com/en/latest/deployment/composer/), a [Drush Make file](http://docs.drupalvm.com/en/latest/deployment/drush-make/), with a [Local Drupal codebase](http://docs.drupalvm.com/en/latest/deployment/local-codebase/), or even a [Drupal multisite installation](http://docs.drupalvm.com/en/latest/deployment/multisite/).

If you want to install a Drupal 8 site locally with minimal fuss, just:

  1. Install [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
  2. Download or clone this project to your workstation.
  3. `cd` into this project directory and run `vagrant up`.

But Drupal VM allows you to build your site exactly how you like, using whatever tools you need, with almost infinite flexibility and customization!

### 1 - Install Vagrant and VirtualBox

Download and install [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

You can also use an alternative provider like Parallels or VMware. (Parallels Desktop 11+ requires the "Pro" or "Business" edition and the [Parallels Provider](http://parallels.github.io/vagrant-parallels/), and VMware requires the paid [Vagrant VMware integration plugin](http://www.vagrantup.com/vmware)).

Notes:

  - **For faster provisioning** (macOS/Linux only): *[Install Ansible](http://docs.ansible.com/intro_installation.html) on your host machine, so Drupal VM can run the provisioning steps locally instead of inside the VM.*
  - **For stability**: Because every version of VirtualBox introduces changes to networking, for the best stability, you should install Vagrant's `vbguest` plugin: `vagrant plugin install vagrant-vbguest`.
  - **NFS on Linux**: *If NFS is not already installed on your host, you will need to install it to use the default NFS synced folder configuration. See guides for [Debian/Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-14-04), [Arch](https://wiki.archlinux.org/index.php/NFS#Installation), and [RHEL/CentOS](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-centos-6).*

  - **Versions**: *Make sure you're running the latest releases of Vagrant, VirtualBox, and Ansible-as of late 2016, Drupal VM recommends: Vagrant 1.8.6, VirtualBox 5.1.10+, and Ansible 2.2.x*

### 2 - Build the Virtual Machine

  1. Download this project and put it wherever you want.
  2. (Optional) Copy `default.config.yml` to `config.yml` and modify it to your liking.
  3. Create a local directory where Drupal will be installed and configure the path to that directory in `config.yml` (`local_path`, inside `vagrant_synced_folders`).
  4. Open Terminal, `cd` to this directory (containing the `Vagrantfile` and this README file).
  5. Type in `vagrant up`, and let Vagrant do its magic.

Once the process is complete, you will have a Drupal codebase available inside the `drupal/` directory of the project.

Note: *If there are any errors during the course of running `vagrant up`, and it drops you back to your command prompt, just run `vagrant provision` to continue building the VM from where you left off. If there are still errors after doing this a few times, post an issue to this project's issue queue on GitHub with the error.*

### 3 - Configure your host machine to access the VM.

  1. [Edit your hosts file](http://www.rackspace.com/knowledge_center/article/how-do-i-modify-my-hosts-file), adding the line `192.168.88.88  drupalvm.dev` so you can connect to the VM.
    - You can have Vagrant automatically configure your hosts file if you install the `hostsupdater` plugin (`vagrant plugin install vagrant-hostsupdater`). All hosts defined in `apache_vhosts` or `nginx_hosts` will be automatically managed. `vagrant-hostmanager` is also supported.
    - The `auto_network` plugin (`vagrant plugin install vagrant-auto_network`) can help with IP address management if you set `vagrant_ip` to `0.0.0.0` inside `config.yml`.
  2. Open your browser and access [http://drupalvm.dev/](http://drupalvm.dev/). The default login for the admin account is `admin` for both the username and password.

## Extra software/utilities

By default, this VM includes the extras listed in the `config.yml` option `installed_extras`:

    installed_extras:
      - adminer
      # - blackfire
      - drupalconsole
      - drush
      # - elasticsearch
      # - java
      - mailhog
      # - memcached
      # - newrelic
      # - nodejs
      - pimpmylog
      # - redis
      # - ruby
      # - selenium
      # - solr
      # - tideways
      # - upload-progress
      - varnish
      # - xdebug
      # - xhprof

If you don't want or need one or more of these extras, just delete them or comment them from the list. This is helpful if you want to reduce PHP memory usage or otherwise conserve system resources.

## Using Drupal VM

Drupal VM is built to integrate with every developer's workflow. Many guides for using Drupal VM for common development tasks are available on the [Drupal VM documentation site](http://docs.drupalvm.com).

## Updating Drupal VM

Drupal VM follows semantic versioning, which means your configuration should continue working (potentially with very minor modifications) throughout a major release cycle. Here is the process to follow when updating Drupal VM between minor releases:

  1. Read through the [release notes](https://github.com/geerlingguy/drupal-vm/releases) and add/modify `config.yml` variables mentioned therein.
  2. Do a diff of your `config.yml` with the updated `default.config.yml` (e.g. `curl https://raw.githubusercontent.com/geerlingguy/drupal-vm/master/default.config.yml | git diff --no-index config.yml -`).
  3. Run `vagrant provision` to provision the VM, incorporating all the latest changes.

For major version upgrades (e.g. 2.x.x to 3.x.x), it may be simpler to destroy the VM (`vagrant destroy`) then build a fresh new VM (`vagrant up`) using the new version of Drupal VM.

## System Requirements

Drupal VM runs on almost any modern computer that can run VirtualBox and Vagrant, however for the best out-of-the-box experience, it's recommended you have a computer with at least:

  - Intel Core processor with VT-x enabled
  - At least 4 GB RAM (higher is better)
  - An SSD (for greater speed with synced folders)

## Other Notes

  - To shut down the virtual machine, enter `vagrant halt` in the Terminal in the same folder that has the `Vagrantfile`. To destroy it completely (if you want to save a little disk space, or want to rebuild it from scratch with `vagrant up` again), type in `vagrant destroy`.
  - To log into the virtual machine, enter `vagrant ssh`. You can also get the machine's SSH connection details with `vagrant ssh-config`.
  - When you rebuild the VM (e.g. `vagrant destroy` and then another `vagrant up`), make sure you clear out the contents of the `drupal` folder on your host machine, or Drupal will return some errors when the VM is rebuilt (it won't reinstall Drupal cleanly).
  - You can change the installed version of Drupal or drush, or any other configuration options, by editing the variables within `config.yml`.
  - Find out more about local development with Vagrant + VirtualBox + Ansible in this presentation: [Local Development Environments - Vagrant, VirtualBox and Ansible](http://www.slideshare.net/geerlingguy/local-development-on-virtual-machines-vagrant-virtualbox-and-ansible).
  - Learn about how Ansible can accelerate your ability to innovate and manage your infrastructure by reading [Ansible for DevOps](http://www.ansiblefordevops.com/).

## License

This project is licensed under the MIT open source license.

## About the Author

[Jeff Geerling](http://www.jeffgeerling.com/) created Drupal VM in 2014 for a more efficient Drupal site and core/contrib development workflow. This project is featured as an example in [Ansible for DevOps](http://www.ansiblefordevops.com/).
