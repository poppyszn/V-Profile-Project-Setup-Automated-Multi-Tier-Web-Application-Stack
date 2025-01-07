#!/bin/bash

# -----------------------------------
# Install and configure Memcached
# -----------------------------------

# Install EPEL repository and Memcached
sudo dnf install epel-release -y    # Enable EPEL repository
sudo dnf install memcached -y       # Install Memcached package

# Start and enable Memcached service
sudo systemctl start memcached      # Start Memcached service
sudo systemctl enable memcached     # Enable Memcached service to start on boot
sudo systemctl status memcached     # Check Memcached service status

# Update Memcached configuration to allow external connections
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached
sudo systemctl restart memcached    # Restart Memcached service to apply changes

# Configure firewall for Memcached
firewall-cmd --add-port=11211/tcp                 # Open TCP port 11211
firewall-cmd --runtime-to-permanent               # Make firewall changes permanent
firewall-cmd --add-port=11111/udp                 # Open UDP port 11111
firewall-cmd --runtime-to-permanent               # Make firewall changes permanent

# Start Memcached with custom configuration
sudo memcached -p 11211 -U 11111 -u memcached -d  # Run Memcached with custom ports
