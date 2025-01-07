#!/bin/bash

# -----------------------------------
# Install RabbitMQ and dependencies
# -----------------------------------

# Install EPEL repository and wget
sudo yum install epel-release -y           # Enable EPEL repository
sudo yum install wget -y                   # Install wget for downloading files

# Add RabbitMQ repository and install RabbitMQ server
cd /tmp/
dnf -y install centos-release-rabbitmq-38  # Add CentOS RabbitMQ repository
dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server  # Install RabbitMQ server

# -----------------------------------
# Start and enable RabbitMQ service
# -----------------------------------
systemctl enable --now rabbitmq-server     # Start RabbitMQ and enable it to start on boot
sudo systemctl start rabbitmq-server       # Ensure RabbitMQ service is running
sudo systemctl enable rabbitmq-server      # Enable RabbitMQ service at boot
sudo systemctl status rabbitmq-server      # Check RabbitMQ service status

# -----------------------------------
# Configure RabbitMQ
# -----------------------------------

# Allow remote connections by updating the RabbitMQ configuration
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'

# Add a RabbitMQ administrator user
sudo rabbitmqctl add_user test test        # Create a new RabbitMQ user with username and password 'test'
sudo rabbitmqctl set_user_tags test administrator  # Assign administrator privileges to the user

# Set permissions for the user
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"  # Grant full permissions to the user

# Restart RabbitMQ service to apply configuration changes
sudo systemctl restart rabbitmq-server

# -----------------------------------
# Configure firewall
# -----------------------------------
firewall-cmd --add-port=5672/tcp           # Allow RabbitMQ traffic on port 5672
firewall-cmd --runtime-to-permanent        # Make firewall changes permanent
