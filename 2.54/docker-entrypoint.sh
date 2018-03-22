#!/bin/bash
until nc -z $GONG_DB_HOST $GONG_DB_PORT; do
    echo "$(date) - waiting for mysql..."
    sleep 1
done

	read -d '' webapp <<EOF
server {
    listen 80;
    server_name $GONG_HOST;
    root /home/app/gor/public;

    # The following deploys your Ruby/Python/Node.js/Meteor app on Passenger.

    # Not familiar with Passenger, and used (G)Unicorn/Thin/Puma/pure Node before?
    # Yes, this is all you need to deploy on Passenger! All the reverse proxying,
    # socket setup, process management, etc are all taken care automatically for
    # you! Learn more at https://www.phusionpassenger.com/.
    passenger_enabled on;
    passenger_user app;
    passenger_app_env production;

    # If this is a Ruby app, specify a Ruby version:
    passenger_ruby /usr/bin/ruby2.2;
}
EOF


echo "Creating file webapp.conf $webapp"

echo "$webapp" > /etc/nginx/sites-enabled/webapp.conf




	read -d '' database <<EOF
$RAILS_ENV: 
  adapter: $GONG_DB_ADAPTER
  database: $GONG_DB_NAME
  encoding: $GONG_DB_ENCODING
  host: $GONG_DB_HOST
  password: $GONG_DB_PASSWORD
  port: $GONG_DB_PORT
  username: $GONG_DB_USERNAME
EOF


echo "Creating file database.yml $database"

echo "$database" > $RAILS_ROOT/config/database.yml

chown -R app:app $RAILS_ROOT/

rake db:migrate

rake db:seed

bundle exec rails runner $RAILS_ROOT/init.rb

chown -R app:app $RAILS_ROOT/

/sbin/my_init