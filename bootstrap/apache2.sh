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
PORTS=(9000 8000)
COUNT=0
for f in "${PROJECTS[@]}"
do
    echo "Listen ${PORTS[$COUNT]}
    <VirtualHost *:${PORTS[$COUNT]}>
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

a2enmod rewrite

service apache2 restart

echo "------------------------------------------------------"
echo "Apache2 installation finished."
echo "------------------------------------------------------"