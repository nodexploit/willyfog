#!/usr/bin/env bash

source install_docker.sh $1

# Set environment variables for dockers (development)
read -r -d '' ENV_VARS << ROTO
export DB_NAME=dbname
export DB_USER=user
export DB_PASS=password
ROTO

echo "$ENV_VARS" >> /home/vagrant/.bashrc

echo "------------------------------------------------------"
echo "Installation finished."
echo "------------------------------------------------------"