#!/bin/bash
# solutions/3/install.sh: How to install the guestbook application with mysql.
# 2014 June 18

yum install -y php httpd mysql-server php-mysql

mkdir /var/www/sites
wget https://github.com/pgwillia/guestbook/archive/v2.0.tar.gz
tar -xvf v2.0.tar.gz -C /var/www/sites
ln -s /var/www/sites/guestbook-2.0/* /var/www/html/
chown -R apache:apache /var/www/html

service mysqld start
mysql < /var/www/sites/guestbook-2.0/schema.sql

service httpd start

