# Use the latest Ubuntu base image
FROM ubuntu:latest

# Update the package repository and install Apache
RUN apt-get update && apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*

# Create a new directory for the custom web files
RUN mkdir -p /var/opt/gci

# Copy the custom webpage.html to the new directory
COPY webpage.html /var/opt/gci/

# Update Apache configuration to serve files from /var/opt/gci
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/opt/gci|' /etc/apache2/sites-available/000-default.conf && \  
    sed -i 's|<Directory /var/www/html>|<Directory /var/opt/gci/>|' /etc/apache2/apache2.conf  

RUN service apache2 restart
 
# Ensure permissions are correct for the new document root
RUN chmod -R 755 /var/opt/gci

# Expose port 80 for HTTP traffic
EXPOSE 80

# Command to start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
