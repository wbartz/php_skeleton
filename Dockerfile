FROM wbartz/lumen:1.0
MAINTAINER William Bartz <williamf.brtz@gmail.com>

ARG FOLDER
WORKDIR /var/www/project

COPY $FOLDER /var/www/project/code
COPY ./init.sh /var/www/project
