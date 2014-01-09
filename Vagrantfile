# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  mc_settings = {
    :domain => 'example.mcdev',
    :docroot => '/home/vagrant/docroot',
    :host_docroot => '../docroot',
    :database_name => 'example_mcdev'
  }

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "mis_ubuntu-precise_20131108"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://s3.amazonaws.com/mis-devops/mis-vagrant-boxes/mis_ubuntu-precise_20131108.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.50.4"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder mc_settings[:host_docroot], mc_settings[:docroot], nfs: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider :virtualbox do |vb|
    # Boot in headless mode.
    vb.gui = false

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # View the documentation for the provider you're using for more
  # information on available options.

  config.vm.provision :shell do |shell|
    # @todo: Evaluate if this is still necessary.
    shell.inline = <<-EOH
      # We should update packages so that chef can get all the pkgs it needs.
      apt-get update

      # Mysql keeps firing off before build_essentials can be added... I don't
      # know why just yet.
      apt-get -y install build-essential
    EOH
  end

  # Enable provisioning with chef solo, specifying a cookbooks path
  # (relative to this Vagrantfile), and adding some recipes and/or roles.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = [
      'cookbooks/mc-cookbooks',
      'cookbooks/vendor-cookbooks'
    ]

    chef.add_recipe 'lamp'
    #chef.add_recipe 'utils::varnish'
    chef.add_recipe 'dev-tools'
    #chef.add_recipe 'dev-tools::phpmyadmin'
    #chef.add_recipe 'dev-tools::xhprof'
    #chef.add_recipe 'dev-tools::webgrind'
    chef.add_recipe 'drush'
    chef.add_recipe 'example-mcdev'
    #chef.add_recipe 'utils::solr'
    chef.add_recipe "utils::scripts"

    # You may also specify custom attribute overrides:
    chef.json = {
      #:solr => {
      #  :version => '3.6.2'
      #}
      #:utils => {
      #  :solr => {
      #    :drupal_module_path = "#{mc_settings[:docroot]}/sites/all/modules/apachesolr"
      #  }
      #}
    }.merge(mc_settings)
  end
end
