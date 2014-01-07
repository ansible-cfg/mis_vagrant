# Description

A base Vagrant + Chef development environment.

# Requirements

* Vagrant >= 1.3.5
* Virtualbox >= 4.1.x
* NFS @todo: Add version

**Not tested on Windows**

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
        IdentityFile ~/.ssh/vagrant_insecure_private_key
        User vagrant


5. Recursively clone the repo so that submodules are initialized. Consult with
project lead for the repo information.

        $ git clone --recursive [my repo]

    Note the --recursive flag is necessary to checkout the submodules as part
    of the initial clone. Alternatively, you can clone the repo and provision the
    vendor recipes separately.

        $ git clone [my repo]
        $ cd [my repo]
        $ git submodule init
        $ git submodule update

6. Make sure the /etc/hosts file contains the latest hosts entries from the
[Vagrant IP address allocation](https://docs.google.com/a/mediacurrent.com/spreadsheet/pub?key=0AuLhQk3Txl-JdFNGOGNEV0twcUlwR09tWkU1NVNMZnc&output=html)
spreadsheet "All hosts" column.

7. Change directories into the mis_vagrant directory and execute `vagrant up`
This command will download and bring up the virtual machine.
**(Be patient.  This will take a few minutes.)**

        $ cd [my repo]/mis_vagrant
        $ vagrant up

    At some point during the process, you will be prompted for an administrator
    password. This is to create the NFS export to share your local filesystem
    with the VM and is safe to acknowledge. *If this process fails check that your
    firewall has been disabled.*

8. Once step 7 is complete, the virtual machine is up and running in your local.
Congratulations! View your site using the domain configured in step 6.

9. Install site with drush install profile and optionally synch with shared dev 
environment. Your project lead may provide an installation profile specific to
the project. If not, minimal will be fine for now.

    The drush aliases below are for the mis_example project. You can find the
    proper aliases to use for your project in [my repo]/docroot/sites/all/drush

        $ cd [my repo]/docroot
        $ drush @example.mcdev site-install minimal --sites-subdir=example.mcdev \
          --db-url=mysql://root:password@localhost/example_mcdev

    For the sql sync here, you may need to add the standard mcstage entry to your
    host machine's ~/.ssh/config

        $ vi ~/.ssh/config
        Host mcstage
          HostName 174.143.170.119
          Port 7022
          ForwardAgent yes
          User your-mc-user-name
        $ drush sql-sync @example.dev @example.mcdev

10. To ssh into your new pre-configured development environment, use the
following. (Optional)

        $ cd [my repo]/mis_vagrant
        $ vagrant ssh

    Changes may be made in the host docroot filesystem and they will be
    reflected on the dev site.
