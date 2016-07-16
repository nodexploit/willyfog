#!/usr/bin/env bash

# Bootstrap the database with the necessary databases and schema.

mysql -uroot -proot -e "CREATE DATABASE willyfog"
mysql -uroot -proot willyfog < /home/vagrant/willyfog/projects/willyfog-api/db/schema.sql