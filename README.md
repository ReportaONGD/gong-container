# Supported tags and respective `Dockerfile` links

-	[`2.54`, `latest` (*2.54/Dockerfile*)](https://github.com/docker-library/redmine/blob/16b22cf462b639577c55b7086fe7529278d00a94/3.4/Dockerfile)

# Quick reference

-	**Where to get help**:  
	[the Docker Community Forums](https://forums.docker.com/), [the Docker Community Slack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)

-	**Where to file issues**:  

-	**Maintained by**:  

-	**Published image artifact details**:  

-	**Image updates**:  

-	**Source of this description**:  

-	**Supported Docker versions**:  
	[the latest release](https://github.com/docker/docker-ce/releases/latest) (down to 1.6 on a best-effort basis)

# What is Gong-R?

Gong is a free and open source, web-based project management and issue tracking tool. It allows users to manage multiple projects and associated subprojects. 

> [http://gong.es](http://gong.es)

![logo](http://gong.es/IMG/siteon0.png)

# How to use this image

## Run Gong-R with [`Docker-compose`](https://github.com/docker/compose)

```yaml
version: '3'

services:

  db:
    image: mysql:5.7
    restart: always
    command: --sql-mode=''
    env_file: 
      - .env
    ports:
      - 3306:3306

  gong:
    build: 
      context: gong
      dockerfile: Dockerfile
    restart: always
    depends_on:
      - db
    env_file: 
      - .env
    ports:
      - 80:80
      - 443:443

  gong-reporte:
    build: 
      context: gong-reporte
      dockerfile: Dockerfile
    env_file: 
      - .env
    depends_on:
      - db
      - gong
    ports:
      - 8080:8080

```

Run `docker-compose -f docker-compose.yml up`, wait for it to initialize completely, and visit  `http://localhost`, or `http://host-ip` (as appropriate).


## Environment Variables

When you start the `Gong-R` image, you can adjust the configuration of the instance chanbing defautl values in .env file.

### `MYSQL_ROOT_PASSWORD`

This variable sets the root password of database. If unspecified, it will default to `example` for MySQL.

### `MYSQL_PORT`

This variable allows you to specify a custom database connection port. If unspecified, it will default to the regular connection ports: `3306`.

### `RAILS_ENV`

This variable sets the environment for the application. If unspecified, it will default to `production`.

### `GONG_DB_ADAPTER`

This variable sets the database adapter for the application. If unspecified, it will default to `mysql2`. **Unless you're sure of what you're doing. Do not change this value**

### `GONG_DB_HOST`

This variable allows you to specify a custom database name. If unspecified, it will default to `db`. **Unless you're sure of what you're doing. Do not change this value**

### `GONG_DB_PORT`

This variable allows you to specify a custom database connection port. If unspecified, it will default to the regular connection ports: `3306`.

### `GONG_DB_USER`

This variable sets the user that Redmine and any rake tasks use to connect to the specified database. If unspecified, it will default to `root`.

### `GONG_DB_PASSWORD`

This variable sets the password that the specified user will use in connecting to the database. If unspecified, it will default to `example`.

### `GONG_DB_NAME`

This variable sets the database that Gong will use in the specified database server. If not specified, it will default to `gong`.

### `GONG_DB_ENCODING`

This variable sets the character encoding to use when connecting to the database server. If unspecified, it will use the default for the `mysql2` library ([`UTF-8`](https://github.com/brianmario/mysql2/tree/18673e8d8663a56213a980212e1092c2220faa92#mysql2---a-modern-simple-and-very-fast-mysql-library-for-ruby---binding-to-libmysql)) for MySQL.


### `GONG_HOST`

This variable sets hostname where Gong is running . If not specified, it will default to `gong`. **Unless you're sure of what you're doing. Do not change this value**

### `GONG_PORT`

This variable sets the hostname port where Gong is listening . If not specified, it will default to `80`. **Unless you're sure of what you're doing. Do not change this value**

### `GONG_PORT_SSL`

This variable sets the hostname port where Gong is listening . If not specified, it will default to `443`. **Unless you're sure of what you're doing. Do not change this value**

### `GOR_PLUGINS`

This variable sets the path of plugin's Gong . If not specified, it will default to `/home/app/plugins`. **Unless you're sure of what you're doing. Do not change this value**

### `GONGR_URL`

This variable sets the url of Gong-Reporte . If not specified, it will default to `http://localhost:8080/gong_r`. 

### `RAILS_VAR`

This variable sets the path of Gong's files. If not specified, it will default to `/var/lib/gong/files`. 

### `AD_CLIENT_ID`

This variable sets the Client Id for the Oauht communication between Gong a Gong-Reporte. If not specified, it will default to `71800f89-46e5-499a-b90c-f6163a90280cAA`. 

### `AD_CLIENT_PW`

This variable sets the Client Password for the Oauht communication between Gong a Gong-Reporte. If not specified, it will default to `f4363b9e-12a8-421e-88ae-010d406fa208AA`. 

GONG_REPORTE_HOST=gong-reporte
GONG_REPORTE_PORT=8080
GONG_REPORTE_DB_HOST=db
GONG_REPORTE_DB_NAME=gongr
GONG_REPORTE_DB_USER=gongr
GONG_REPORTE_DB_PASSWORD=gongr
GONG_REPORTE_FILES=/var/opt/Gong-Reporte
GONG_REPORTE_LOG=/var/log/gongr
GONG_URL=http://localhost

# License



