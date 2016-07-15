#!/usr/bin/env bash

if [ "$EUID" -ne 0  ]
then
    echo "Please run as root"
    exit
fi

# Install MySQL Server
# Credentials:
#   User: root
#   Password: root
# If you want a different password, change next two lines.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get -y install mysql-server-5.6

echo "------------------------------------------------------"
echo "MySQL 5.6 installation finished."
echo "------------------------------------------------------"