FROM phusion/passenger-ruby22

LABEL maintainer="Raul Victoria Martin <raul.victoria@ezentis.com>"
LABEL version_gong="%%GONG_VERSION%%"
LABEL version_webservices="2.47"

# Set correct environment variables.
ENV HOME /root

# Define environment
ENV RAILS_ROOT=/home/app/gor \
	RAILS_ENV=production  \
    GONG_VER=%%GONG_VERSION%% \
    GOR_PLUGINS=/home/app/plugins \
    GONG_WEBSERVICE_VER=2.47 \
	GONG_DB_ADAPTER=mysql2 \
	GONG_DB_NAME=gong \
	GONG_DB_ENCODING=utf8 \
	GONG_DB_HOST=localhost \
	GONG_DB_PASSWORD=root \
	GONG_DB_PORT=3306 \
	GONG_DB_USERNAME=root \
	GONG_HOST=localhost \
	GONG_HOST_PORT=80 \
	GONG_HOST_PORT_SSL=443 \
	GONGR_URL=http://localhost:8080/gong_r \
	RAILS_VAR=/var/lib/gong/files \
	AD_CLIENT_ID=71800f89-46e5-499a-b90c-f6163a90280cAA \
	AD_CLIENT_PW=f4363b9e-12a8-421e-88ae-010d406fa208AA 



# ...put your own build instructions here...
RUN apt-get update -qq && apt-get install -y \
		build-essential \
		libpq-dev \
		git \
		libmysqlclient-dev \
		fontconfig \
		gcc \
		libmagickcore-dev \
		libmagickwand-dev \
		nodejs \
		mysql-client \
		subversion \
		netcat

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove default nginx site 
RUN rm /etc/nginx/sites-enabled/default

# Download Gong
RUN svn export https://gong.org.es/svn/gong/tags/gong-gor-$GONG_VER $RAILS_ROOT

# Download Webservice Plugin. Good one hasn't a tag we use what in the trunk is.
RUN svn export https://gong.org.es/svn/gong/trunk/plugins/webservice $GOR_PLUGINS/webservice

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler

WORKDIR $RAILS_ROOT

COPY init.rb $RAILS_ROOT
ADD gong-env.conf /etc/nginx/main.d/gong-env.conf

# Finish establishing our Ruby enviornment
RUN bundle install

RUN chown -R app:app /home/app/

# Enabling nginx
RUN rm -f /etc/service/nginx/down

COPY docker-entrypoint.sh /
CMD "/docker-entrypoint.sh"
