#!/bin/bash
# solutions/1/install.sh: How to install the guestbook application.
# 2014 June 18

yum install -y php httpd

mkdir /var/www/sites
wget https://github.com/pgwillia/guestbook/archive/v1.0.tar.gz
tar -xvf v1.0.tar.gz -C /var/www/sites
ln -s /var/www/sites/guestbook-1.0/* /var/www/html/
chown -R apache:apache /var/www/html

service httpd start

