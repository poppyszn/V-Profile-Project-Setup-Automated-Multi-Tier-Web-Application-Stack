#!/bin/bash

# -----------------------------------
# Variables and URLs
# -----------------------------------
TOMURL="https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz"

# -----------------------------------
# Install required packages
# -----------------------------------
dnf -y install java-17-openjdk java-17-openjdk-devel  # Install Java 17
dnf install git wget -y                              # Install Git and wget

# -----------------------------------
# Download and set up Apache Tomcat
# -----------------------------------
cd /tmp/
wget $TOMURL -O tomcatbin.tar.gz                     # Download Tomcat
EXTOUT=$(tar xzvf tomcatbin.tar.gz)                  # Extract the Tomcat archive
TOMDIR=$(echo $EXTOUT | cut -d '/' -f1)              # Get the extracted directory name

# Create a dedicated Tomcat user
useradd --shell /sbin/nologin tomcat                 # Add a non-login user for Tomcat

# Move Tomcat files to /usr/local/tomcat and set permissions
rsync -avzh /tmp/$TOMDIR/ /usr/local/tomcat/
chown -R tomcat:tomcat /usr/local/tomcat

# -----------------------------------
# Create systemd service for Tomcat
# -----------------------------------
rm -rf /etc/systemd/system/tomcat.service            # Remove existing Tomcat service file, if any

cat <<EOT>> /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
Group=tomcat

WorkingDirectory=/usr/local/tomcat
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/var/tomcat/%i/run/tomcat.pid
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINA_BASE=/usr/local/tomcat

ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd and start Tomcat
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

# -----------------------------------
# Install Apache Maven
# -----------------------------------
cd /tmp/
wget https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip  # Download Maven
unzip apache-maven-3.9.9-bin.zip                         # Extract Maven archive
cp -r apache-maven-3.9.9 /usr/local/maven3.9             # Move Maven to /usr/local
export MAVEN_OPTS="-Xmx512m"                             # Set Maven options

# -----------------------------------
# Build and deploy the application
# -----------------------------------
git clone -b local https://github.com/hkhcoder/vprofile-project.git  # Clone the project repository
cd vprofile-project
/usr/local/maven3.9/bin/mvn install                                  # Build the application

# Stop Tomcat to deploy the application
systemctl stop tomcat
sleep 20

# Remove any existing ROOT applications
rm -rf /usr/local/tomcat/webapps/ROOT*

# Deploy the new application WAR file
cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Start Tomcat with the new application
systemctl start tomcat
sleep 20

# -----------------------------------
# Disable Firewall (Optional)
# -----------------------------------
systemctl stop firewalld
systemctl disable firewalld

# Restart Tomcat to ensure all changes are applied
systemctl restart tomcat
