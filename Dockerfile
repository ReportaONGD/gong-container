FROM phusion/passenger-ruby22

LABEL maintainer=""
LABEL version_gong="2.54"
LABEL version_webservices="2.47"

# Set correct environment variables.
ENV HOME /root

# Define where our application will live inside the image
ENV RAILS_ROOT=/home/app/gor \
	RAILS_ENV=production  \
    GONG_VER=2.54 \
    GOR_PLUGINS=/home/app/plugins \
    GONG_WEBSERVICE_VER=2.47 


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

# Dockerfile:
RUN rm /etc/nginx/sites-enabled/default
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf

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
