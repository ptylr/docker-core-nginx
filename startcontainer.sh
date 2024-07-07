#!/bin/bash

/usr/local/ptylr/nginx/sbin/nginx
tail -f /usr/local/ptylr/nginx/logs/access.log
