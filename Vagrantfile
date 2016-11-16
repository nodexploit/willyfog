# -*- mode: ruby -*-
# vi: set ft=ruby :

#################################################################################################
#                                                                                               #
# Please read before `vagrant up`!                                                              #
#                                                                                               #
# Configuration                                                                                 #
# ---------------------                                                                         #
# PUBLIC_GUEST_IP: If you set this, this IP will be used by your machine in your local network. #
# To set it execute:                                                                            #
#       `echo 'export PUBLIC_GUEST_IP=<desiredIP>' >> ~/.bashrc`                                #
#                                                                                               #
# PUBLIC_GUEST_IP: You have to set this to use the debugger correctly.                          #                                                                           #
#       `echo 'export PUBLIC_HOST_IP=<desiredIP>' >> ~/.bashrc`                                 #
#                                                                                               #
# PRIVATE_GUEST_IP: This IP will always be used by your machine in your private network.        #
#                                                                                               #
# PROJECTS: enumerated list of the different projects under `projects\` directory.              #
#                                                                                               #
#################################################################################################

# Constants
# ---------------------
PUBLIC_GUEST_IP = "#{ENV['PUBLIC_GUEST_IP']}"
PUBLIC_HOST_IP = "#{ENV['PUBLIC_HOST_IP']}"
PRIVATE_GUEST_IP = '192.168.33.10'
PROJECTS = ['willyfog-api', 'willyfog-openid', 'willyfog-web']

Vagrant.configure(2) do |config|
  # Base Box
  # --------------------
  config.vm.box = "ubuntu/trusty64"

  # Private network
  # --------------------
  config.vm.network "private_network", ip: PRIVATE_GUEST_IP

  # Public network
  # --------------------
  unless PUBLIC_GUEST_IP.length == 0
    config.vm.network "public_network", ip: PUBLIC_GUEST_IP
  end

  # Optional (Remove if desired)
  config.vm.provider :virtualbox do |vb|
    # How much RAM to give the VM (in MB)
    # -----------------------------------
    vb.memory = "2048"
  end

  # Provisioning Script
  # --------------------
  config.vm.provision "shell", path: "bootstrap/docker.sh"
  config.vm.provision "shell", path: "bootstrap/oracle_java_8.sh"
  config.vm.provision "shell", path: "bootstrap/sbt.sh"
  config.vm.provision "shell", path: "bootstrap/mysql56.sh"
  config.vm.provision "shell", path: "bootstrap/bootstrap_db.sh"
  config.vm.provision "shell", path: "bootstrap/apache2.sh"
  config.vm.provision "shell", path: "bootstrap/php7_modphp.sh", args: [PUBLIC_HOST_IP]
  config.vm.provision "shell", inline: "service apache2 restart", run: "always"

  # Synced Folder
  # --------------------
  config.vm.synced_folder ".", "/home/vagrant/#{File.basename(Dir.getwd)}"
  Dir.foreach('projects') do |project_name|
    next if !PROJECTS.include? project_name
    config.vm.synced_folder "./projects/#{project_name}", "/var/www/#{project_name}", mount_options: [ "dmode=774", "fmode=664" ], owner: 'vagrant', group: 'www-data'
  end
end
