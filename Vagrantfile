# Vagrantfile configuration for multiple VMs
Vagrant.configure("2") do |config|
  # Enable host manager plugin for managing host entries
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Database VM configuration
  config.vm.define "db01" do |db01|
    db01.vm.box = "eurolinux-vagrant/centos-stream-9"
    db01.vm.box_version = "9.0.48"
    db01.vm.hostname = "db01"
    db01.vm.network "private_network", ip: "192.168.56.100"
    db01.vm.provider "virtualbox" do |vb|
      vb.memory = "600"
    end
    db01.vm.provision "shell", path: "mysql.sh" # Provisioning script for MySQL
  end

  # Memcache VM configuration
  config.vm.define "mc01" do |mc01|
    mc01.vm.box = "eurolinux-vagrant/centos-stream-9"
    mc01.vm.box_version = "9.0.48"
    mc01.vm.hostname = "mc01"
    mc01.vm.network "private_network", ip: "192.168.56.101"
    mc01.vm.provider "virtualbox" do |vb|
      vb.memory = "600"
    end
    mc01.vm.provision "shell", path: "memcache.sh" # Provisioning script for Memcache
  end

  # RabbitMQ VM configuration
  config.vm.define "rmq01" do |rmq01|
    rmq01.vm.box = "eurolinux-vagrant/centos-stream-9"
    rmq01.vm.box_version = "9.0.48"
    rmq01.vm.hostname = "rmq01"
    rmq01.vm.network "private_network", ip: "192.168.56.102"
    rmq01.vm.provider "virtualbox" do |vb|
      vb.memory = "600"
    end
    rmq01.vm.provision "shell", path: "rabbitmq.sh" # Provisioning script for RabbitMQ
  end

  # Tomcat application VM configuration
  config.vm.define "app01" do |app01|
    app01.vm.box = "eurolinux-vagrant/centos-stream-9"
    app01.vm.box_version = "9.0.48"
    app01.vm.hostname = "app01"
    app01.vm.network "private_network", ip: "192.168.56.103"
    app01.vm.provider "virtualbox" do |vb|
      vb.memory = "800"
    end
    app01.vm.provision "shell", path: "tomcat.sh" # Provisioning script for Tomcat
  end

  # Nginx web server VM configuration
  config.vm.define "web01" do |web01|
    web01.vm.box = "ubuntu/jammy64"
    web01.vm.hostname = "web01"
    web01.vm.network "private_network", ip: "192.168.56.104"
    # Uncomment the next line for public network
    # web01.vm.network "public_network"
    web01.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "800"
    end
    web01.vm.provision "shell", path: "nginx.sh" # Provisioning script for Nginx
  end
end
