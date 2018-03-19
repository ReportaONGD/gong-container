#!/bin/bash

until nc -z $GONG_REPORTE_DB_HOST $MYSQL_PORT; do
    echo "$(date) - waiting for mysql..."
    sleep 1
done

	read -d '' gong_db <<EOF
create DATABASE /*!32312 IF NOT EXISTS*/ $GONG_DB_NAME;
grant ALL ON $GONG_DB_NAME.* TO $GONG_DB_USER@$GONG_DB_NAME IDENTIFIED BY '$GONG_DB_PASSWORD';
EOF

	echo "Creando $gong_db"
	echo "$gong_db" > ./gong_db.sql

mysql -h $GONG_DB_HOST -u root -p$MYSQL_ROOT_PASSWORD < ./gong_db.sql

rm ./gong_db.sql

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

chown app:app $RAILS_ROOT/config/database.yml

rake db:migrate

rake db:seed

bundle exec rails runner $RAILS_ROOT/init.rb

/sbin/my_init