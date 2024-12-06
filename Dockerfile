FROM centos:latest
RUN yum install -y httpd \
    zip \
    unzip
COPY photogenic.zip /var/tmp/
WORKDIR /var/tmp/
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
