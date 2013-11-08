# Description

A base Vagrant + Chef development environment.

# Requirements

* Vagrant >= 1.3.5
* Virtualbox >= 4.3.x

# Installation

1. Download and install VirtualBox (>= 4.3.x) from [here](https://www.virtualbox.org/wiki/Downloads).

2. Download and install Vagrant 1.3.5 or later from [here](http://downloads.vagrantup.com/).

3. Clone the repo, Retrieve the submodules. Consult with project lead for the repo information.
```
$ git clone --recursive [my repo]
```
Note the `--recursive` flag, that is necessary to checkout the submodules as part of the initial clone.
Alternatively, you can clone the repo and provision the vendor recipes separately.
```
$ git clone [my repo]
$ git submodule init
$ git submodule update
```

4. Make sure the `/etc/hosts` file contains the following entries. If there are multiple entries for localhost, move the 127.0.0.1 mapping to the top.
        127.0.0.1 localhost
        10.0.5.3  twcrb.dev
Replace twcrb.dev and the IP address with whatever your particular project admin states.

5. Now, cd into the cloned directory and execute `vagrant up` - This command will download and bring up the virtual machine.
**(Be patient.  This will take a few minutes and will take longer the first time it is run.)**
```
$ vagrant up
```
At some point during the process, you will be prompted for an administrator password. This is to create the NFS export to share your local filesystem with the VM and is safe to acknowledge.

6. Once step 5 is complete, the virtual machine is up and running in your local. Congratulations! View your site using the domain configured in step 4.

7. To start working on the codebase, open up PhpStorm (or editor of your choice) and create a new project with project base as workspace/twc\_cms folder.

8. To ssh into your new pre-configured development environment, use the following. (Optional)
```
$ vagrant ssh
```
Changes may be made in the host docroot filesystem and they will
be reflected on the dev site.

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
