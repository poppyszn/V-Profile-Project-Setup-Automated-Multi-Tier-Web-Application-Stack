#!/bin/bash

# Define the database password
DATABASE_PASS='admin123'

# -----------------------------------
# Install required packages
# -----------------------------------
# Install EPEL repository and necessary packages
sudo yum install epel-release -y         # Enable EPEL repository
sudo yum install git zip unzip -y        # Install Git and archive utilities
sudo yum install mariadb-server -y       # Install MariaDB server

# -----------------------------------
# Start and enable MariaDB service
# -----------------------------------
sudo systemctl start mariadb             # Start MariaDB service
sudo systemctl enable mariadb            # Enable MariaDB service to start on boot

# -----------------------------------
# Clone the project repository
# -----------------------------------
cd /tmp/
git clone -b main https://github.com/hkhcoder/vprofile-project.git  # Clone the repository

# -----------------------------------
# Secure MariaDB installation
# -----------------------------------
# Set root password and remove unnecessary users/databases
sudo mysqladmin -u root password "$DATABASE_PASS"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

# -----------------------------------
# Set up the application database
# -----------------------------------
sudo mysql -u root -p"$DATABASE_PASS" -e "create database accounts"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'localhost' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'%' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" accounts < /tmp/vprofile-project/src/main/resources/db_backup.sql
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

# Restart MariaDB service to apply changes
sudo systemctl restart mariadb

# -----------------------------------
# Configure firewall for MariaDB
# -----------------------------------
sudo systemctl start firewalld                  # Start firewall service
sudo systemctl enable firewalld                 # Enable firewall service to start on boot
sudo firewall-cmd --get-active-zones            # Display active firewall zones
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent  # Allow MariaDB traffic on port 3306
sudo firewall-cmd --reload                      # Reload firewall rules
sudo systemctl restart mariadb                  # Restart MariaDB to ensure all changes take effect
