# Use the Ubuntu 20.04 base image
FROM ubuntu:latest

# Update the package lists and install Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a new user account named "User"
RUN useradd -ms /bin/bash User && \
    echo 'User:Password' | chpasswd

# Copy the webpage to the container
COPY apache/index.html /var/www/html/

# Set ownership of the /var/www/html/ directory to the Apache user and group
RUN chown -R www-data:www-data /var/www/html/

# Remove default conf that states port 80
RUN rm /etc/apache2/sites-enabled/000-default.conf

# Change the default port in the ports.conf file from 80 to REPLACE_PORT
RUN sed -i 's/Listen 80/Listen REPLACE_PORT/g' /etc/apache2/ports.conf

# Expose port REPLACE_PORT for HTTP traffic
EXPOSE REPLACE_PORT

# Start Apache and listen on port REPLACE_PORT when the container is started
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND", "-e", "info"]
