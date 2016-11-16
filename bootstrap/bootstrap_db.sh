#!/usr/bin/env bash

# Bootstrap the database with the necessary databases and schema.

mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS willyfog_db"
mysql -uroot -proot willyfog_db < /home/vagrant/willyfog/projects/willyfog-api/database/schema.sql
mysql -uroot -proot willyfog_db < /home/vagrant/willyfog/projects/willyfog-api/database/countries.sql
mysql -uroot -proot willyfog_db < /home/vagrant/willyfog/projects/willyfog-api/database/search.sql
mysql -uroot -proot willyfog_db < /home/vagrant/willyfog/projects/willyfog-api/database/request.sql