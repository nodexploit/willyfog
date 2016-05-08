# -*- mode: ruby -*-
# vi: set ft=ruby :

##
# SETTINGS
##
# Static IP that will have the virtual machine in your local network.
guest_ip = '192.168.50.4'

Vagrant.configure(2) do |config|

  # Base Box
  # --------------------
  config.vm.box = "ubuntu/trusty64"

  # Connect to IP
  # --------------------
  config.vm.network :public_network, ip: guest_ip

  # Forward to Port
  # --------------------
  #config.vm.network :forwarded_port, guest: 80, host: 8080

  # Optional (Remove if desired)
  config.vm.provider :virtualbox do |vb|
    # How much RAM to give the VM (in MB)
    # -----------------------------------
    vb.memory = "2048"
  end

  # Provisioning Script
  # --------------------
  config.vm.provision "shell", path: "bootstrap/provision.sh"
  config.vm.provision "shell", path: "bootstrap/install_docker.sh", args: ["vagrant"]

  # Synced Folder
  # --------------------
  config.vm.synced_folder ".", "/home/vagrant/play-docker"
end