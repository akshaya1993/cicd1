# Use the latest Ubuntu base image
FROM ubuntu:latest

# Update the package repository and install Apache
RUN apt-get update && apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*

# Remove any default index.html files
RUN rm -f /var/www/html/index.html

# Copy the custom index1.html to the Apache root directory
COPY index1.html /var/www/html/index.html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Command to start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
