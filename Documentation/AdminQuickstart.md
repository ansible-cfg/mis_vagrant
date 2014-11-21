# Admin Quickstart Guide

## Introduction

The vagrant build is designed to be added to an existing project and may sit
alongside or live within the project repository (as a git submodule). Which
method makes the most sense depends on project needs and architecture.

It is expected that you have installed and tested out the MIS Example project
build prior to attempting to set up a vagrant build for your own project. This
will provide you with a working vagrant environment and knowledge of what will
need to be provided to other team members.

The example client project branch is found on bitbucket

    git clone --recursive -b master git@bitbucket.org:mediacurrent/mis_example.git
    git clone --recursive -b master git@bitbucket.org:mediacurrent/mis_vagrant_example.git

This example project is intended to be used with a fork of the mis_vagrant project.
This Vagrant project's branch is built off master like any other Vagrant projects 
branch should be.

## Installation

Follow all instructions in the [User Quickstart](UserQuickstart.md) to ensure
that you have all required dependencies.

1. Create (or clone locally) your client project repo. This will be referred to
as [client_repo] for the remainder of this document.

2. Contact a Vagrant team member to create your project fork. This repo will be 
used exclusively to track this instance of vagrant and will be referred to as 
[vagrant_repo] for the remainder of this document.

3. Clone the project fork repo into a directory parallel to your repo.

      [client_repo]$ cd .. && git clone --recursive -b master git@bitbucket.org:mediacurrent/[project-code]_vagrant.git

4. Change directory into the [vagrant_repo]. The master branch is where changes
specific to your project are kept and maintained over time. Remember to replace
"client" and "project" with names that are appropriate for your project.

        [vagrant_repo]$ git submodule init && git submodule update

5. Modify the Vagrantfile to match the desired server configuration
(more detail below).

    1. Modify the Vagrantfile mc_settings to specify the local domain and
    host_docroot for your project relative to the Vagrantfile.

            mc_settings = {
              :domain       => 'example.mcdev',
              :docroot      => '/home/vagrant/docroot',
              :host_docroot => '../docroot',
              :database_name => 'example_mcdev'
            }

        * :docroot: The path to the apache docroot on the guest virtual machine
        (running inside virtualBox) and should not be changed unless you really
        know what you are doing.
        * :host_docroot: The location of the project docroot relative to
        this file on the host machine.

    2. Add the domain/IP for this installation to the [Vagrant IP address allocation](https://docs.google.com/a/mediacurrent.com/spreadsheet/ccc?key=0AuLhQk3Txl-JdFNGOGNEV0twcUlwR09tWkU1NVNMZnc&usp=sharing).
    spreadsheet. Specify the next IP in the current range and add to the proper
    column in the spreadsheet. Use this IP/domain combination in the following steps.
    The /etc/hosts entry will be populated for you by the spreadsheet. If you do
    not have access to edit this spreadsheet, a member of DevOps will help you.
    You will get something like the following from the "All hosts" column.

            #Vagrant Hosts Entries
            192.168.50.4 example.mcdev

        Instructions have been provided in the user quickstart guide to add an entry
        to their /etc/hosts file that matches this. Please provide this to your team
        members after setup.

    3. Modify the line in the Vagrantfile with the IP generated in previous step.

            # Create a private network, which allows host-only access to the machine
            # using a specific IP.
            config.vm.network :private_network, ip: "192.168.50.4"

6. Create or add to existing drushrc file within your project repository
(not the vagrant branch you just created)
docroot/sites/all/drush/[project shortname].aliases.drushrc.php with the
following.

        // Vagrant local development vm.
        $aliases['mcdev'] = array(
          'uri' => 'example.mcdev',
          'root' => '/home/vagrant/docroot',
          'remote-host' => 'example.mcdev',
          'path-aliases' => array(
            '%drush-script' => '/usr/local/bin/drush',
          ),
          'remote-user' => 'vagrant',
        );

7. Check in your vagrant configuration and push to a project specific *projects/client--project*
branch.

        [vagrant_repo]$ git commit -a -m 'creating branch for project name'
        [vagrant_repo]$ git push origin master

8. Create the setup guide for your project by replacing the [vagrant_repo] README.md 
file with setup instructions similar to the [UserQuickstart](Documentation/UserQuickstart.md).

9. Test your setup guide by following it exactly in a temporary directory. Make sure
everything works as expected.

10. *Note:* Additional configuration is possible and explained in the [Customization
guide](Customization.md). The two areas of intended configuration are by editing the *Vagrantfile* and
through the creation of project-specific cookbooks.

## Troubleshooting
