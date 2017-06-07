#!/bin/bash

echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
apt-get update
apt-get install rabbitmq-server


cd /opt/ 
git clone git://github.com/alanxz/rabbitmq-c.git
cd rabbitmq-c
git submodule init
git submodule update

apt-get install python-simplejson libtool autoconf automake gcc pkg-config
autoreconf -i && ./configure && make && make install

apt-get install php7.0-dev php-pear
pecl install amqp

echo 'extension=amqp.so' > /etc/php/7.0/mods-available/amqp.ini
ln -s /etc/php/7.0/mods-available/amqp.ini /etc/php/7.0/cli/conf.d/20-amqp.ini
ln -s /etc/php/7.0/mods-available/amqp.ini /etc/php/7.0/fpm/conf.d/20-amqp.ini
service php7.0-fpm restart