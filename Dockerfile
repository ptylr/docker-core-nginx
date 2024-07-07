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
RUN apt-get -yqq install build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev vsftpd

RUN mkdir /scratch
ADD nginx-1.27.0.tar.gz /scratch
WORKDIR /scratch/nginx-1.27.0
RUN ./configure --prefix=/usr/local/ptylr/nginx --with-http_ssl_module --with-pcre --with-http_v2_module
RUN make && make install
RUN rm -rf /scratch/nginx-1.27.0
EXPOSE 80/tcp 443/tcp

RUN sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
RUN useradd -p "Xl/4mx4ZrQ.SQ" ptylr
EXPOSE 20/tcp 21/tcp

ADD startcontainer.sh /opt/container/
RUN chmod u+x /opt/container/startcontainer.sh

# Launch service
ENTRYPOINT [ "/bin/bash", "/opt/container/startcontainer.sh" ]
