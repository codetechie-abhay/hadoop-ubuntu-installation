Here's a `README.md` file for your repository that includes instructions for using the provided installation script, enhanced with emojis:

---

# 📦 Hadoop Ubuntu Installation

Welcome to the **Hadoop Ubuntu Installation** repository! 🚀 This guide provides an automated script to set up Hadoop 3.3.6 on Ubuntu 20.04 effortlessly. Follow the instructions below to get your distributed computing environment up and running smoothly. 🖥️✨

## Features

- 🔧 **Easy Setup**: Automated script for installing and configuring Hadoop.
- 🔑 **Secure SSH Keys**: Enhance security with SSH key setup for password-less authentication.
- ☕ **Java Installation**: Quick Java setup, a prerequisite for running Hadoop.
- ⚙️ **Environment Configuration**: Script sets environment variables for seamless Hadoop operations.
- 📝 **Comprehensive Configurations**: Configures core Hadoop files to fit your requirements.
- 🚀 **Final Steps**: Formats HDFS and starts Hadoop services with ease.
- 🌐 **Web Interfaces**: Access Hadoop NameNode and ResourceManager through your browser.

## Getting Started

### Prerequisites

- **OS**: Ubuntu 20.04
- **Hadoop Version**: 3.3.6

### Steps

1. **Clone the repository**:

   ```sh
   git clone https://github.com/0xA13H4Y/hadoop-ubuntu-installation.git
   cd hadoop-ubuntu-installation
   ```

2. **Create the installation script**:

   1. Create a new file named `install_hadoop.sh` in your home directory:

      ```sh
      nano ~/install_hadoop.sh
      ```

   2. Copy and paste the following script into the `install_hadoop.sh` file:

      ```sh
      #!/bin/bash

      # Update and upgrade the system
      sudo apt update && sudo apt upgrade -y

      # Install OpenSSH server and client
      sudo apt install openssh-server openssh-client -y

      # Generate SSH keys
      ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
      cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
      chmod 600 ~/.ssh/authorized_keys
      chmod 700 ~/.ssh

      # Verify SSH setup
      ssh localhost

      # Install Java
      sudo apt install openjdk-11-jdk -y

      # Download and extract Hadoop
      wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
      tar xzf hadoop-3.3.6.tar.gz
      sudo mv hadoop-3.3.6 /usr/local/hadoop

      # Configure environment variables
      echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.bashrc
      echo "export HADOOP_HOME=/usr/local/hadoop" >> ~/.bashrc
      echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> ~/.bashrc
      echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> ~/.bashrc
      echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> ~/.bashrc
      echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> ~/.bashrc
      echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> ~/.bashrc
      echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native" >> ~/.bashrc
      echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> ~/.bashrc
      echo "export HADOOP_OPTS=\"-Djava.library.path=\$HADOOP_HOME/lib/native\"" >> ~/.bashrc
      echo "export PDSH_RCMD_TYPE=ssh" >> ~/.bashrc
      source ~/.bashrc

      # Configure Hadoop files
      HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop

      # core-site.xml
      cat <<EOL > \$HADOOP_CONF_DIR/core-site.xml
      <configuration>
          <property>
              <name>fs.default.name</name>
              <value>hdfs://localhost:9000</value>
          </property>
      </configuration>
      EOL

      # hdfs-site.xml
      cat <<EOL > \$HADOOP_CONF_DIR/hdfs-site.xml
      <configuration>
          <property>
              <name>dfs.replication</name>
              <value>1</value>
          </property>
          <property>
              <name>dfs.namenode.name.dir</name>
              <value>/home/$USER/hadoop2-dir/namenode-dir</value>
          </property>
          <property>
              <name>dfs.datanode.data.dir</name>
              <value>/home/$USER/hadoop2-dir/datanode-dir</value>
          </property>
      </configuration>
      EOL

      # mapred-site.xml
      cat <<EOL > \$HADOOP_CONF_DIR/mapred-site.xml
      <configuration>
          <property>
              <name>yarn.app.mapreduce.am.env</name>
              <value>HADOOP_MAPRED_HOME=/usr/local/hadoop/etc/hadoop</value>
          </property>
          <property>
              <name>mapreduce.map.env</name>
              <value>HADOOP_MAPRED_HOME=/usr/local/hadoop/etc/hadoop</value>
          </property>
          <property>
              <name>mapreduce.reduce.env</name>
              <value>HADOOP_MAPRED_HOME=/usr/local/hadoop/etc/hadoop</value>
          </property>
      </configuration>
      EOL

      # yarn-site.xml
      cat <<EOL > \$HADOOP_CONF_DIR/yarn-site.xml
      <configuration>
          <property>
              <name>yarn.nodemanager.aux-services</name>
              <value>mapreduce_shuffle</value>
          </property>
          <property>
              <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
              <value>org.apache.hadoop.mapred.ShuffleHandler</value>
          </property>
          <property>
              <description>The hostname of the RM.</description>
              <name>yarn.resourcemanager.hostname</name>
              <value>localhost</value>
          </property>
          <property>
              <description>The address of the applications manager interface in the RM.</description>
              <name>yarn.resourcemanager.address</name>
              <value>\${yarn.resourcemanager.hostname}:8032</value>
          </property>
      </configuration>
      EOL

      # hadoop-env.sh
      echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> \$HADOOP_CONF_DIR/hadoop-env.sh

      # mapred-env.sh
      echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> \$HADOOP_CONF_DIR/mapred-env.sh

      # yarn-env.sh
      echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> \$HADOOP_CONF_DIR/yarn-env.sh

      # Format HDFS
      cd /usr/local/hadoop
      hdfs namenode -format

      # Start Hadoop services
      start-all.sh

      # Print completion message
      echo "🎉 Hadoop setup complete successfully! 🎉"
      ```

3. Save the file and exit the editor (`Ctrl+X`, then `Y`, and `Enter`).

4. Make the script executable:

   ```sh
   chmod +x ~/install_hadoop.sh
   ```

5. Run the script:

   ```sh
   ~/install_hadoop.sh
   ```

## Access Hadoop Interfaces

- **NameNode**: [http://localhost:9870](http://localhost:9870)
- **ResourceManager**: [http://localhost:8088](http://localhost:8088)

## Stop Hadoop Services

To stop all Hadoop services, run:

```sh
stop-all.sh
```

## Contributing

Feel free to contribute to this project by opening issues or submitting pull requests.

---

🎉 **Hadoop setup complete successfully!** 🎉

---
