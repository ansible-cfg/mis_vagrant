# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  mc_settings = {
    :domain => 'ncihd7.mcdev',
    :docroot => '/home/vagrant/domains/ncihd7.mcdev'
  }

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

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

  config.vm.synced_folder mc_settings[:domain], mc_settings[:docroot]

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  config.vm.provision :shell do |shell|
    shell.inline = <<-EOH
      # We should update packages so that chef can get all the pkgs it needs.
      apt-get update

      # Mysql keeps firing off before build_essentials can be added... I don't
      # know why just yet
      apt-get -y install build-essential
    EOH
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = [
      'provisioning/cookbooks/mc-cookbooks',
      'provisioning/cookbooks/vendor-cookbooks'
    ]

    chef.add_recipe 'lamp'
    chef.add_recipe 'dev-tools'
    chef.add_recipe 'drush'
    chef.add_recipe 'ncihd7-mcdev'

    # You may also specify custom JSON attributes:
    chef.json = {}.merge(mc_settings)
  end
end
