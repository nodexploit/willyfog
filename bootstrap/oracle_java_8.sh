#!/usr/bin/env bash

if [ "$EUID" -ne 0  ]
then
    echo "Please run as root"
    exit
fi

## Oracle JVM
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer
update-java-alternatives -s java-8-oracle
apt-get -y install oracle-java8-set-default

echo "------------------------------------------------------"
echo "Oracle Java 8 installation finished."
echo "------------------------------------------------------"