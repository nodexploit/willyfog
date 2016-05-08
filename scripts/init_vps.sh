#!/usr/bin/env bash

## DESC ##
# Realiza las recomendaciones de Digital Ocean para un VPS nuevo.
# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04

###### Funciones ######

# En un fichero, sustituye una cadena que concuerde con una expresion regular por otra cosa, usando sed
sedreplace() { sed -i "s/$1/$2/" $3; } # Uso: sedreplace regexp_needle replacement file

USAGE_TOOL="Usage: $0 <SSH_USER> <SSH_PASSWORD>"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z "$1"  ]
  then echo "$USAGE_TOOL"
  exit
else
  if [ -z "$2" ]
    then echo "$USAGE_TOOL"
    exit
  fi
fi

USER=$1
PASSWORD=$2

# Add SSH user
adduser --disabled-password --gecos "" ${USER}
# Set password to the created user
echo "$USER:$PASSWORD"| chpasswd
# Add user to sudoers
gpasswd -a ${USER} sudo

# Disable SSH root connection
sedreplace "PermitRootLogin yes" "PermitRootLogin no" /etc/ssh/sshd_config

service ssh restart

source ../bootstrap/install_docker.sh ${USER}

echo "------------------------------------------------------"
echo "Installation finished."
echo "------------------------------------------------------"