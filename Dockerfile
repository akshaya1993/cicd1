FROM ubuntu:latest

# Update the package repository and install required packages
RUN apt-get update && apt-get install -y \
    apache2 \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Copy the zip file into the container
COPY photogenic.zip /var/tmp/

# Set the working directory
WORKDIR /var/tmp/

# Unzip the file and move contents
RUN unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Set Apache to run in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]

# Expose port 80 for HTTP traffic
EXPOSE 80
