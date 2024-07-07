#         __          .__
# _______/  |_ ___.__.|  |_______
# \____ \   __<   |  ||  |\_  __ \
# |  |_> >  |  \___  ||  |_|  | \/
# |   __/|__|  / ____||____/__|
# |__|         \/
#
# https://ptylr.com
# https://www.linkedin.com/in/ptylr/
#
##########################################################################
# Image: ptylr/docker-core-nginx
##########################################################################
FROM ptylr/docker-core-java
MAINTAINER Paul Taylor <me@ptylr.com>

ENV REFRESHED_AT 2024-07-07

RUN apt-get -yqq update
RUN apt-get -yqq install build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev vsftpd ufw

RUN mkdir /scratch
ADD nginx-1.27.0.tar.gz /scratch
WORKDIR /scratch/nginx-1.27.0
RUN ./configure --prefix=/var/www/html --with-http_ssl_module --with-pcre --with-http_image_filter_module=dynamic --with-http_v2_module --with-stream=dynamic --with-http_addition_module --with-http_mp4_module
RUN make && make install
CMD rm -rf /scratch

CMD sudo systemctl enable vsftpd
CMD sudo systemctl start vsftpd
CMD sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
CMD adduser --gecos "" --disabled-password ptylr
CMD chpasswd <<<"ptylr:ptylr"
CMD sudo ufw allow ssh
CMD sudo ufw allow 20/tcp
CMD sudo ufw allow 21/tcp
CMD sudo ufw enable

ADD startcontainer.sh /opt/container/
RUN chmod u+x /opt/container/startcontainer.sh

# Launch service
ENTRYPOINT [ "/bin/bash", "/opt/container/startcontainer.sh" ]
