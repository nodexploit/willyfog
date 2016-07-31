#!/usr/bin/env bash

cd ~/willyfog/projects/willyfog-api

# Update the project if necessary

git pull origin master

# Updating DB

read -r -d '' DROPEANDO << ROTO
DROP DATABASE willyfog_db;
CREATE DATABASE willyfog_db;
ROTO

echo "$DROPEANDO" > /tmp/drop.sql

mysql -u$DB_USER -p$DB_PASS willyfog_db < /tmp/drop.sql

mysql -u$DB_USER -p$DB_PASS willyfog_db < /home/web1/willyfog/projects/willyfog-api/database/schema.sql

mysql -u$DB_USER -p$DB_PASS willyfog_db < /home/web1/willyfog/projects/willyfog-api/database/countries.sql

mysql -u$DB_USER -p$DB_PASS willyfog_db < /home/web1/willyfog/projects/willyfog-api/database/search.sql

mysql -u$DB_USER -p$DB_PASS willyfog_db < /home/web1/willyfog/projects/willyfog-api/database/request.sql

mysql -u$DB_USER -p$DB_PASS willyfog_db -e 'UPDATE willyfog_db.oauth_client SET redirect_uri = "http://popokis.com:8010/login/callback" WHERE client_id="webclient";'

# Build the project

sbt dist

# Check if willyfog-api is already running
cd target/universal/willyfog-api-1.0/
DUMMY_VAR=$(cat RUNNING_PID)
kill -9 $DUMMY_VAR
cd ..
rm -rf willyfog-api-1.0

unzip willyfog-api-1.0.zip
cd willyfog-api-1.0

bin/willyfog-api -Dplay.crypto.secret=wde3R4tTdrs -Dhttp.port=7000 &


echo "***********************************"
echo "Remember do that: GRANT ALL PRIVILEGES ON willyfog_db.* TO '$DB_USER'@'%';"
echo "***********************************"
