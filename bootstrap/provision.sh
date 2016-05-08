#!/usr/bin/env bash

apt-get -y install unzip

## Oracle JVM
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer
update-java-alternatives -s java-8-oracle
apt-get -y install oracle-java8-set-default

# Install activator
wget https://downloads.typesafe.com/typesafe-activator/1.3.10/typesafe-activator-1.3.10.zip
unzip typesafe-activator-1.3.10.zip
mv activator-dist-1.3.10 /opt/
ln -s /opt/activator-dist-1.3.10/bin/activator /usr/local/bin/activator
chmod +x /usr/local/bin/activator

# Set environment variables for dockers (development)
read -r -d '' ENV_VARS << ROTO
export DB_NAME=dbname
export DB_USER=user
export DB_PASS=password
ROTO

echo "$ENV_VARS" >> /home/vagrant/.bashrc