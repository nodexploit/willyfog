#!/usr/bin/env bash

while true; do
    read -p "Do you wish to run this script? (The database will be erased if already created): [y/n] " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

cd ~/willyfog/projects/willyfog-api

# Update the project if necessary

git pull origin master

# Updating DB

read -r -d '' DROPEANDO << ROTO
DROP DATABASE willyfog_db;
CREATE DATABASE willyfog_db;
ROTO

echo "$DROPEANDO" > /tmp/drop.sql

mysql -u"$DB_USER" -p"$DB_PASS" willyfog_db < /tmp/drop.sql

mysql -u"$DB_USER" -p"$DB_PASS" willyfog_db < /home/web1/willyfog/projects/willyfog-api/database/schema.sql

for i in /home/web1/willyfog/projects/willyfog-api/database/inserts/* ; do
  if [ -f "$i" ]; then
    echo "Dumping script ${i} ..."
    mysql -u"$DB_USER" -p"$DB_PASS" willyfog_db < ${i}
  fi
done

mysql -u"$DB_USER" -p"$DB_PASS" willyfog_db -e 'UPDATE willyfog_db.oauth_client SET redirect_uri = "http://popokis.com:8010/login/callback" WHERE client_id="webclient";'

# Build the project

sbt dist

# Check if willyfog-api is already running
cd target/universal/willyfog-api-1.0/
DUMMY_VAR=$(cat RUNNING_PID)
kill -9 "$DUMMY_VAR"
cd ..
rm -rf willyfog-api-1.0

unzip willyfog-api-1.0.zip
cd willyfog-api-1.0

bin/willyfog-api -Dplay.crypto.secret=wde3R4tTdrs -Dhttp.port=7000 &


echo "***********************************"
echo "Remember do that (with root mysql privileges): GRANT ALL PRIVILEGES ON willyfog_db.* TO '$DB_USER'@'%';"
echo "***********************************"
