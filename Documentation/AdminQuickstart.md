# Admin Quickstart Guide

## Introduction

The vagrant build is designed to be added to an existing project and may sit
alongside or the project repository can live within (as a git submodule). The project repository submodule is the standard directory configuration expected for new
projects and will be covered here. Some legacy projects have the
"alongside" method.

It is expected that you have installed and tested out the MIS Example project
build prior to attempting to set up a vagrant build for your own project. This
will provide you with a working vagrant environment and knowledge of what new
team members will need.

The example client project branch is found on bitbucket and provides a working
example of a properly configured vagrant instance.

    git clone --recursive -b master git@bitbucket.org:mediacurrent/mis_example.git
    git clone --recursive -b master git@bitbucket.org:mediacurrent/mis_vagrant_example.git


## Installation

Follow all instructions in the [User Quickstart](UserQuickstart.md) to ensure
that you have all required dependencies.

1. Contact a Vagrant team member in the #mis-vagrant slack channel to create your
project's fork. This repo will be used exclusively to track your teams' instance
of vagrant and will be referred to as [vagrant_repo] for the remainder of this
document. At the same time, request someone in the channel to reserve a unique
IP address for your project. Specify the hostname that will be used (ex. projectsite.mcdev).

2. Clone the [vagrant_repo].

          git clone -b master git@bitbucket.org:mediacurrent/[project-code]_vagrant.git

3. Change directory into the [vagrant_repo]. The project branch is where changes
specific to your project are kept and maintained over time. Remember to replace
"client" and "project" with names that are appropriate for your project. Since
git submodules are in use, ensure the project repository submodule is added:

          [vagrant_repo]$ git checkout -b projects/[project_name]
          [vagrant_repo]$ git submodule add -b [project_name] git@bitbucket.org:mediacurrent/project_name].git

4. Edit .gitmodules and add the line:

          ignore = all

5. Modify the Vagrantfile to create the desired server configuration
(more detail below).

    1. Modify the config.yml to specify the local domain name, the
    host_docroot for your project (relative to the Vagrantfile), and the database
    name (usually [project-code]_mcdev).

			vagrant_hostname: example.mcdev
			vagrant_machine_name: example_mcdev
			vagrant_ip: 192.168.50.4
			...
			local_path: ./[client_repo]/docroot
			...
			servername: "example.mcdev"
			...
			server_name: "example.mcdev"
			...
			drupal_major_version: 7
			...
			drush_version: 7.1.0

    2. The domain/IP requested earlier is accessible in the [Vagrant IP address allocation](https://docs.google.com/a/mediacurrent.com/spreadsheet/ccc?key=0AuLhQk3Txl-JdFNGOGNEV0twcUlwR09tWkU1NVNMZnc&usp=sharing).
    spreadsheet. Use this IP/domain combination in the following steps.
    The /etc/hosts entry will be populated for you by the spreadsheet and will look
    something like this.

            #Vagrant Hosts Entries
            192.168.50.4 example.mcdev adminer.mcdev xhprof.mcdev pimpmylog.example.mcdev

        Instructions have been provided in the user quickstart guide to add an entry
        to the host machine's /etc/hosts file that matches this. Please provide
        this new IP/Domain to your team members as a part of the setup guide you
        will create in step 8.

6. Create or add to existing drushrc file within the [client_repo] at
docroot/sites/all/drush/[project shortname].aliases.drushrc.php with the
following (if the client does not allow this alias to exist, you may put it in
the [vagrant_repo] and provide instructions to the project team on how to use it).

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

7. Check in your vagrant configuration and push to the project branch of your [vagrant_repo].

        [vagrant_repo]$ git commit -a -m 'creating branch for project name'
        [vagrant_repo]$ git push origin projects/[client_repo]

8. Create the setup guide for your project by replacing the [vagrant_repo] README.md
file with setup instructions similar to the [UserQuickstart](Documentation/UserQuickstart.md).
New members of your project team will use this guide to setup their local environment
for the first time. Make sure it is accurate and tested well to save project time.

9. Test your setup guide by following it exactly in a temporary directory. Make sure
everything works as expected. Any problems with the setup guide will be yours to address
later.

10. *Note:* Additional configuration is possible and explained in the [Customization
guide](Customization.md). The two areas of intended configuration are by editing
*config.yml* and through the creation of project-specific roles.

## Updating

General instructions for applying the update to your project:

Check out MIS Vagrant Project fork. The fork should contain the branch with configuration for your project already.
 
    git remote add upstream git@bitbucket.org:mediacurrent/mis_vagrant.git
    git checkout master
    git pull upstream master
    git checkout develop
    git pull upstream develop
    git checkout projects/[project_name]

Merge the release tag into your project branch.

Update your project configuration if required.

Test the merged changes via clean provisioning.

Update your project's readme or setup instructions to reflect the changes.


