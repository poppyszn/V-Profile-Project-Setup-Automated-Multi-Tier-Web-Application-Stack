#!/bin/bash

# -----------------------------------
# Install and configure Nginx
# -----------------------------------

# Install Nginx
apt update                                  # Update package lists
apt install nginx -y                        # Install Nginx package

# -----------------------------------
# Configure Nginx for vproapp
# -----------------------------------
cat <<EOT > vproapp
upstream vproapp {
    server app01:8080;                      # Define upstream server (app01)
}

server {
    listen 80;                              # Listen on port 80 for HTTP traffic

    location / {
        proxy_pass http://vproapp;          # Forward requests to the upstream server
    }
}
EOT

# Move the configuration file to Nginx's sites-available directory
mv vproapp /etc/nginx/sites-available/vproapp

# Remove the default Nginx configuration
rm -rf /etc/nginx/sites-enabled/default

# Enable the vproapp site configuration
ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

# -----------------------------------
# Start and enable Nginx service
# -----------------------------------
systemctl start nginx                       # Start Nginx service
systemctl enable nginx                      # Enable Nginx to start on boot
systemctl restart nginx                     # Restart Nginx to apply changes
