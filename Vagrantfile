# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/focal64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port

  #port 8080 — Use this port when configuring the message broker container with Solace PubSub+ Manager.
  #port 55555 — Your applications can use Solace APIs to connect to the message broker on this port.
  #port 8008 — The JavaScript sample applications below use this port to pass Web Messaging traffic through the message broker.
  #ports 1883 & 8000 — Ports for MQTT connectivity, over TCP and over WebSockets respectively
  #port 5672 — AMQP 1.0 applications using Apache QPID APIs would connect here
  #port 9000 — Use REST to send messaging and event data with Solace’s RESTful API port
  #port 2222 — Use SSH to connect to the Solace Command Line Interface (CLI) for advanced configuration

  config.vm.network "forwarded_port", guest: 3000, host: 3000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 55555, host: 55555, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8008, host: 8008, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 1883, host: 1883, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8000, host: 8000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 5672, host: 5672, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 9000, host: 9000, host_ip: "127.0.0.1"
  #config.vm.network "forwarded_port", guest: 2222, host: 2222, host_ip: "127.0.0.1"
  #config.vm.network "forwarded_port", guest: 8081, host: 8081, host_ip: "127.0.0.1"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     #vb.gui = true
  
     # Customize the amount of memory on the VM:
     vb.memory = "3072"
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  # Where args => "'TENANCY_OCID' 'USER_OCID' 'PUB_KEY_FINGERPRINT' 'OKE_OCID' 'REGION_SHORTNAME' 'INSTALL_KUBECTL_BOOLEAN'"
  config.vm.provision "shell", path: "bootstrap.sh"
end