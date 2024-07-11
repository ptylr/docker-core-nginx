```
        __          .__
_______/  |_ ___.__.|  |_______
\____ \   __<   |  ||  |\_  __ \
|  |_> >  |  \___  ||  |_|  | \/
|   __/|__|  / ____||____/__|
|__|         \/

https://ptylr.com
https://www.linkedin.com/in/ptylr/
```
# ptylr/docker-core-nginx
Extends ptylr/docker-core-java with NGINX 1.2.7 for additional chained images.

```
ubuntu:22.04
  -> docker-core-ubuntu
    -> docker-core-java
      -> docker-core-nginx
```

# Usage
Add nginx.conf to /usr/local/ptylr/nginx/conf/
```shell
worker_processes  1;
user www-data www-data;

error_log  logs/error.log;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       80;
        server_name  localhost;
        root   /var/www/static;

        location / {
            autoindex on;
        }
    }
}

# Licence
MIT License

Copyright (c) 2024 Paul Taylor.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
