# V-Profile Project Setup: Automated Multi-Tier Web Application Stack

Welcome to the **V-Profile Project Setup**, a fully automated, multi-tier web application stack designed for DevOps engineers and developers who want to explore and master infrastructure automation and local R&D. 🚀

---

## ** Project Overview**
In this project, you'll:
- 🏗️ Set up a social networking web application using **Java**.
- 🖥️ Automate the deployment of services like **Nginx**, **Tomcat**, **MySQL**, **Memcached**, and **RabbitMQ**.
- 💾 Build a local lab environment using **Vagrant** and **VirtualBox**.
- 🔄 Gain a foundational understanding for advanced projects involving **Docker**, **Kubernetes**, **Jenkins**, and more.

---

## **🔍 Why This Project?**
1. **Baseline for Advanced Projects:** Learn concepts and workflows to prepare for upcoming challenges like containerization and Kubernetes deployments. 🛠️
2. **Local Lab Setup:** Create a repeatable and automated local environment to test and experiment with multi-tier applications. 💡

---

## **📐 Architecture**

### **Services in the Stack**
- **Nginx:** Load balancing service for routing requests. 
- **Tomcat:** Java web application server to host your app. 
- **MySQL:** Database service for user data. 
- **Memcached:** Database caching for faster access. 
- **RabbitMQ:** Dummy message queue for added complexity. 

### **Automation Tools**
- **Vagrant:** Automates VM creation and provisioning. 
- **VirtualBox:** Hypervisor to host the virtual machines. 
- **Git Bash:** Command-line tool for scripting and version control. 

---

### **🛠️ Tools Required**
Make sure you have the following installed:
- [Oracle VM VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Git Bash](https://git-scm.com/downloads)
- IDE of your choice: **Sublime Text**, **Visual Studio Code**, etc. 

---

## ** Getting Started**
1. Clone this repository:
   ```bash
   git clone https://github.com/poppyszn/V-Profile-Project-Setup-Automated-Multi-Tier-Web-Application-Stack.git
   cd v-profile-setup
   ```
2. Navigate to the Vagrant directory:
    ```bash
    cd vagrant
    ```

3. Spin up the virtual machines:
    ```bash
    vagrant plugin install vagrant-hostmanager
    vagrant up
    ```
  
4. Validate all VMs are up and running:
    ```bash
    vagrant status
    ```

5. Configure and set up services:
  - MySQL
  - Memcached
  - RabbitMQ
  - Tomcat
  - Nginx

6. Build and deploy your Java web application.

7. Open your browser and access the application using the VM's IP address.

### **🎯 Objectives**
Infrastructure Automation: Automate the deployment of multi-tier stacks using Vagrant.
Service Configuration: Gain experience in configuring real-world services.
Research & Development: Build confidence by experimenting in a safe, repeatable local environment.

### **📜 Flow of Execution**
1. Install tools from the prerequisites.
2. Clone the project and navigate to the Vagrant directory.
3. Launch VMs using the Vagrantfile.
4. Set up services one by one:
  - MySQL
  - Memcached
  - RabbitMQ
  - Tomcat
  - Nginx
5. Build and deploy the Java application.
6. Test the setup from your browser.

### Acknowledgments
This project was developed as part of a DevOps training series to demonstrate the deployment of a fully automated, multi-tier web application stack.

