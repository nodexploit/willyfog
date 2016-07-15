#!/usr/bin/env bash

if [ "$EUID" -ne 0  ]
then
    echo "Please run as root"
    exit
fi

# Auxiliary function
contains_element () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

# Install Apache2
apt-get -y install apache2

# Configure virtualhosts
PROJECTS=("willyfog-openid" "willyfog-web")
DOMAINS=(openid.willyfog.com willyfog.com)
PORTS=(9000 8000)
COUNT=0
for f in /home/vagrant/$1/projects/*
do
    contains_element "$(basename ${f})" "${PROJECTS}"
    if [ $? -eq 0 ]; then
        echo "Listen ${PORTS[$COUNT]}
        <VirtualHost *:${PORTS[$COUNT]}>
            ServerName ${DOMAINS[$COUNT]}
            DocumentRoot /var/www/$(basename ${f})/public/
            ErrorLog  /var/www/$(basename ${f})/logs/projects-error.log
            CustomLog /var/www/$(basename ${f})/logs/projects-access.log combined
            <Directory '/var/www/$(basename ${f})/public/'>
                    Options Indexes Followsymlinks
                    AllowOverride All
                    Require all granted
            </Directory>
        </VirtualHost>" > /etc/apache2/sites-available/$(basename "$f").conf

        a2ensite $(basename ${f})
    fi
    COUNT=$((COUNT + 1))
done

a2enmod rewrite

service apache2 restart

echo "------------------------------------------------------"
echo "Apache2 installation finished."
echo "------------------------------------------------------"