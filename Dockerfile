# Use the latest Ubuntu base image
FROM ubuntu:latest

# Update the package repository and install Apache
RUN apt-get update && apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /var/www/html/index1.html

# Copy the HTML file into the default Apache directory
COPY index1.html /var/www/html/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Command to start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
