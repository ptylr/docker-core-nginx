#!/bin/bash

sudo service vsftpd start
/usr/local/ptylr/nginx/sbin/nginx
tail -f /usr/local/ptylr/nginx/logs/access.log
