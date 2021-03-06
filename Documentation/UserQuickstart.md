# Description

A base Vagrant + Ansible development environment.

# Requirements

* Vagrant >= 1.6.5
* Virtualbox >= 4.3.3
* NFS @todo: Add version

**Not tested or supported on Windows operating systems**

# Installation

Note: Steps 1-4 are only needed for the initial install of vagrant.

1. Download and install VirtualBox (>= 4.1.x)
from [here](https://www.virtualbox.org/wiki/Downloads).

2. Download and install Vagrant 1.3.5 or later
from [here]( http://www.vagrantup.com/downloads.html).

3. Add the vagrant ssh key to your .ssh directory

        $ ln -s ~/.vagrant.d/insecure_private_key ~/.ssh/vagrant_insecure_private_key
        $ chmod 600 ~/.ssh/vagrant_insecure_private_key

4. Add mcdev top level domain to your ssh config by editing [home]/.ssh/config and
adding the following lines

        Host *.mcdev
        ForwardAgent yes
        IdentityFile ~/.ssh/vagrant_insecure_private_key
        User vagrant

5. Clone the project repository (contains the Drupal files) in a directory of your
choice. For the remainder of this document we will refer to this repo as the
"[client_repo]".

6. Recursively clone the vagrant git repo so that submodules are initialized. Consult with
project lead for the repo information. This git checkout should cause the vagrant
repository to be alongside the project repository (siblings). For the remainder
of this document we will refer to this repository as the "[vagrant_repo]"

        $ git clone --recursive [vagrant_repo]

    Note the --recursive flag is necessary to checkout the submodules as part
    of the initial clone. Alternatively, you can clone the repo and update the submodules separately.

        $ git clone [vagrant_repo]
        $ cd [vagrant_repo]
        $ git submodule init
        $ git submodule update
		$ git submodule foreach git pull origin develop

7. Make sure the /etc/hosts file contains the latest hosts entries from the
[Vagrant IP address allocation](https://docs.google.com/a/mediacurrent.com/spreadsheet/pub?key=0AuLhQk3Txl-JdFNGOGNEV0twcUlwR09tWkU1NVNMZnc&output=html)
spreadsheet "All hosts" column.

8. Change directories into the top-level [vagrant_repo] directory and execute the
`vagrant up` terminal command This command will download and bring up the virtual
machine. **(Be patient.  This will take a few minutes.)**

        $ cd [vagrant_repo]
        $ vagrant up

    At some point during the process, you will be prompted for an administrator
    password. This is to create the NFS export to share your local filesystem
    with the Vagrant VM and is safe to acknowledge. *If this process fails check
    that your firewall is not blocking NFS operations.*

9. Once step 8 is complete, the virtual machine is up and running in your local.
Congratulations! View your site using the domain provided in step 10.

10. Install site with drush install profile and optionally synch with shared dev 
environment. Your project lead may provide an installation profile specific to
the project. If not, minimal will be fine for now.

    The drush aliases below are for the mis_example project. You can find the
    proper aliases to use for your project in [client_repo]/docroot/sites/all/drush

        $ cd [project repo]/docroot
        $ drush @example.mcdev site-install minimal --sites-subdir=example.mcdev \
          --db-url=mysql://root:password@localhost/example_mcdev

    For this sql sync example, you may need to add the standard mcstage entry to your
    host machine's ~/.ssh/config

        $ vi ~/.ssh/config
        Host mcstage
          HostName 174.143.170.119
          Port 7022
          ForwardAgent yes
          User your-mc-user-name
        $ drush sql-sync @example.dev @example.mcdev

11. To ssh into your new pre-configured development environment, use the
following. (Optional)

        $ cd [vagrant_repo]
        $ vagrant ssh

    Changes may be made in the host docroot filesystem and they will be
    reflected on the dev site.

Additional information:

Generate a login link

- `$ cd [project repo]/docroot`
- `$ drush @example.mcdev uli`
   or
- `$ vagrant ssh`
- `$ cd /home/vagrant/docroot/sites/example.mcdev`
- `$ drush uli`
- Log out of the vagrant server (ctrl-d usually works well)

Run the code-review.sh tests ( Currently Drupal 7 only).

- `$ vagrant ssh -c "/vagrant/tests/code-review.sh example.mcdev /home/vagrant/docroot"`

Run the security-review.sh tests ( Currently Drupal 7 only).

- `$ vagrant ssh -c "/vagrant/tests/security-review.sh example.mcdev /home/vagrant/docroot"`

Run the pa11y-review.sh tests.

- `$ vagrant ssh -c "/vagrant/tests/pa11y/pa11y-review.sh example.mcdev"`


* [UserQuickstart](Documentation/UserQuickstart.md)
* [AdminQuickstart](Documentation/AdminQuickstart.md)
* [Customization](Documentation/Customization.md)
* [FAQ](Documentation/FAQ.md)
* [Gitflow](Documentation/Gitflow.md)

![Drupal VM Logo](https://raw.githubusercontent.com/geerlingguy/drupal-vm/master/docs/images/drupal-vm-logo.png)

[![Build Status](https://travis-ci.org/geerlingguy/drupal-vm.svg?branch=master)](https://travis-ci.org/geerlingguy/drupal-vm) [![Documentation Status](https://readthedocs.org/projects/drupal-vm/badge/?version=latest)](http://docs.drupalvm.com)

[Drupal VM](http://www.drupalvm.com/) is A VM for local Drupal development, built with Vagrant + Ansible.

This project aims to make spinning up a simple local Drupal test/development environment incredibly quick and easy, and to introduce new developers to the wonderful world of Drupal development on local virtual machines (instead of crufty old MAMP/WAMP-based development).

It will install the following on an Ubuntu 14.04 (by default) linux VM:

  - Apache 2.4.x (or Nginx 1.x)
  - PHP 5.5.x (configurable)
  - MySQL 5.5.x
  - Drush (configurable)
  - Drupal Console (if using Drupal 8+)
  - Drupal 6.x, 7.x, or 8.x.x (configurable)
  - Optional:
    - Varnish 4.x
    - Apache Solr 4.10.x (configurable)
    - Node.js
    - Selenium, for testing your sites via Behat
    - Ruby
    - Memcached
    - XHProf, for profiling your code
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

  - `config.yml`: Contains variables like the VM domain name and IP address, PHP and MySQL configuration, etc.
  - `drupal.make.yml`: Contains configuration for the Drupal core version, modules, and patches that will be downloaded on Drupal's initial installation (more about [Drush make files](https://www.drupal.org/node/1432374)).

If you want to switch from Drupal 8 (default) to Drupal 7 or 6 on the initial install, do the following:

  1. Update the Drupal `version` and `core` inside the `drupal.make.yml` file.
  2. Update `drupal_major_version` inside `config.yml`.

## Quick Start Guide

This Quick Start Guide will help you quickly build a Drupal 8 site on the Drupal VM using the included example Drush make file. You can also use the Drupal VM with a [Local Drupal codebase](http://docs.drupalvm.com/en/latest/deployment/local-codebase/) or even a [Drupal multisite installation](http://docs.drupalvm.com/en/latest/deployment/multisite/).

### 1 - Install dependencies (VirtualBox and Vagrant)

  1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (Drupal VM also works with Parallels or VMware, if you have the [Vagrant VMware integration plugin](http://www.vagrantup.com/vmware)).
  2. Download and install [Vagrant](http://www.vagrantup.com/downloads.html).

Note for Faster Provisioning (Mac/Linux only): *[Install Ansible](http://docs.ansible.com/intro_installation.html) on your host machine, so Drupal VM can run the provisioning steps locally instead of inside the VM.*

Note for Linux users: *If NFS is not already installed on your host, you will need to install it to use the default NFS synced folder configuration. See guides for [Debian/Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-14-04), [Arch](https://wiki.archlinux.org/index.php/NFS#Installation), and [RHEL/CentOS](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-centos-6).*

Note on versions: *Please make sure you're running the latest stable version of Vagrant, VirtualBox, and Ansible, as the current version of Drupal VM is tested with the latest releases. As of August 2015: Vagrant 1.7.4, VirtualBox 5.0.2, and Ansible 1.9.2.*

### 2 - Build the Virtual Machine

  1. Download this project and put it wherever you want.
  2. Make copies of both of the `example.*` files, and modify to your liking:
    - Copy `example.drupal.make.yml` to `drupal.make.yml`.
    - Copy `example.config.yml` to `config.yml`.
  3. Create a local directory where Drupal will be installed and configure the path to that directory in `config.yml` (`local_path`, inside `vagrant_synced_folders`).
  4. Open Terminal, cd to this directory (containing the `Vagrantfile` and this README file).
  5. Type in `vagrant up`, and let Vagrant do its magic.

If you have Ansible installed on your host machine: Run `$ sudo ansible-galaxy install -r provisioning/requirements.yml --force` prior to step 5 (`vagrant up`), otherwise Ansible will complain about missing roles.

Note: *If there are any errors during the course of running `vagrant up`, and it drops you back to your command prompt, just run `vagrant provision` to continue building the VM from where you left off. If there are still errors after doing this a few times, post an issue to this project's issue queue on GitHub with the error.*

### 3 - Configure your host machine to access the VM.

  1. [Edit your hosts file](http://www.rackspace.com/knowledge_center/article/how-do-i-modify-my-hosts-file), adding the line `192.168.88.88  drupalvm.dev` so you can connect to the VM.
    - You can have Vagrant automatically configure your hosts file if you install the `hostsupdater` plugin (`vagrant plugin install vagrant-hostsupdater`). All hosts defined in `apache_vhosts` or `nginx_hosts` will be automatically managed.
    - You can also have Vagrant automatically assign an available IP address to your VM if you install the `auto_network` plugin (`vagrant plugin install vagrant-auto_network`), and set `vagrant_ip` to `0.0.0.0` inside `config.yml`.
  2. Open your browser and access [http://drupalvm.dev/](http://drupalvm.dev/). The default login for the admin account is `admin` for both the username and password.

## Extra software/utilities

By default, this VM includes the extras listed in the `config.yml` option `installed_extras`:

    installed_extras:
      - adminer
      - mailhog
      - memcached
      - pimpmylog
      # - solr
      # - selenium
      - varnish
      - xdebug
      - xhprof

If you don't want or need one or more of these extras, just delete them or comment them from the list. This is helpful if you want to reduce PHP memory usage or otherwise conserve system resources.

## Using Drupal VM

Drupal VM is built to integrate with every developer's workflow. Many guides for using Drupal VM for common development tasks are available on the [Drupal VM documentation site](http://docs.drupalvm.com):

  - [Syncing Folders](http://docs.drupalvm.com/en/latest/extras/syncing-folders/)
  - [Connect to the MySQL Database](http://docs.drupalvm.com/en/latest/extras/mysql/)
  - [Use Apache Solr for Search](http://docs.drupalvm.com/en/latest/extras/solr/)
  - [Use Drush with Drupal VM](http://docs.drupalvm.com/en/latest/extras/drush/)
  - [Use Drupal Console with Drupal VM](http://docs.drupalvm.com/en/latest/extras/drupal-console/)
  - [Use Varnish with Drupal VM](http://docs.drupalvm.com/en/latest/extras/varnish/)
  - [Use MariaDB instead of MySQL](http://docs.drupalvm.com/en/latest/extras/mariadb/)
  - [View Logs with Pimp my Log](http://docs.drupalvm.com/en/latest/extras/pimpmylog/)
  - [Profile Code with XHProf](http://docs.drupalvm.com/en/latest/extras/xhprof/)
  - [Debug Code with XDebug](http://docs.drupalvm.com/en/latest/extras/xdebug/)
  - [Catch Emails with MailHog](http://docs.drupalvm.com/en/latest/extras/mailhog/)
  - [Test with Behat and Selenium](http://docs.drupalvm.com/en/latest/extras/behat/)
  - [PHP 7 on Drupal VM](http://docs.drupalvm.com/en/latest/other/php-7/)
  - [Drupal 6 Notes](http://docs.drupalvm.com/en/latest/other/drupal-6/)

## Other Notes

  - To shut down the virtual machine, enter `vagrant halt` in the Terminal in the same folder that has the `Vagrantfile`. To destroy it completely (if you want to save a little disk space, or want to rebuild it from scratch with `vagrant up` again), type in `vagrant destroy`.
  - When you rebuild the VM (e.g. `vagrant destroy` and then another `vagrant up`), make sure you clear out the contents of the `drupal` folder on your host machine, or Drupal will return some errors when the VM is rebuilt (it won't reinstall Drupal cleanly).
  - You can change the installed version of Drupal or drush, or any other configuration options, by editing the variables within `config.yml`.
  - Find out more about local development with Vagrant + VirtualBox + Ansible in this presentation: [Local Development Environments - Vagrant, VirtualBox and Ansible](http://www.slideshare.net/geerlingguy/local-development-on-virtual-machines-vagrant-virtualbox-and-ansible).
  - Learn about how Ansible can accelerate your ability to innovate and manage your infrastructure by reading [Ansible for DevOps](https://leanpub.com/ansible-for-devops).

## License

This project is licensed under the MIT open source license.

## About the Author

[Jeff Geerling](http://jeffgeerling.com/), owner of [Midwestern Mac, LLC](http://www.midwesternmac.com/), created this project in 2014 so he could accelerate his Drupal core and contrib development workflow. This project, and others like it, are also featured as examples in Jeff's book, [Ansible for DevOps](https://leanpub.com/ansible-for-devops).
