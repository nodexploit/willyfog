#!/usr/bin/env bash

USAGE_TOOL="Usage: $0 <HOSTNAME>"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z "$1"  ]
  then echo "$USAGE_TOOL"
  exit
fi

hostnamectl set-hostname $1

IP=$(ifconfig eth0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

echo "$IP   $1  $1.com" >> /etc/hosts

echo "------------------------------------------------------"
echo "Hostname changes to $1. Please relogin."
echo "------------------------------------------------------"