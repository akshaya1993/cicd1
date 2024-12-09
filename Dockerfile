# Use the latest Ubuntu base image
FROM ubuntu:latest

# Update the package repository and install Apache
RUN apt-get update -y && apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*

# Create the directory for the custom web files
RUN mkdir -p /var/www/html/gci/

# Copy the custom HTML files into the container
COPY ./webpage.html/ /var/www/html/gci/

# Ensure permissions are correct for the new directory
RUN chmod -R 755 /var/www/html/gci/

# Command to start Apache in the foreground
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

