FROM ubuntu:latest
# Update the package repository and install Apache
RUN apt-get update && apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*
# Copy the custom index.html to the Apache root directory
RUN mkdir -p /var/www/mysite
COPY webpage.html /var/www/mysite/.
RUN service apache2 restart
RUN a2dissite 000-default.conf
# Expose port 80 for HTTP traffic
EXPOSE 80
# Command to start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]

