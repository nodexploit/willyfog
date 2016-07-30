#!/usr/bin/env bash

if [ "$EUID" -ne 0  ]
then
    echo "Please run as root"
    exit
fi

apt-get update
# Install Apache2
apt-get -y install apache2

service apache2 restart

# Configure virtualhosts
PROJECTS=(willyfog-openid willyfog-web)
DOMAINS=(openid.willyfog.com willyfog.com)
COUNT=0
for f in "${PROJECTS[@]}"
do
    echo "<VirtualHost *:80>
        ServerName ${DOMAINS[$COUNT]}
        DocumentRoot /var/www/${PROJECTS[$COUNT]}/public/
        ErrorLog  /var/www/${PROJECTS[$COUNT]}/logs/projects-error.log
        CustomLog /var/www/${PROJECTS[$COUNT]}/logs/projects-access.log combined
        <Directory '/var/www/${PROJECTS[$COUNT]}/public/'>
                Options Indexes Followsymlinks
                AllowOverride All
                Require all granted
        </Directory>
    </VirtualHost>" > /etc/apache2/sites-available/${PROJECTS[$COUNT]}.conf

    a2ensite $(basename ${f})
    COUNT=$((COUNT + 1))
done

a2dissite 000-default.conf
a2enmod rewrite

service apache2 restart

echo "192.168.33.10  willyfog.com api.willyfog.com openid.willyfog.com" | tee -a /etc/hosts

echo "------------------------------------------------------"
echo "Apache2 installation finished."
echo "------------------------------------------------------"