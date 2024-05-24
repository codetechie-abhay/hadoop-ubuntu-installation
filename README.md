# hadoop-ubuntu-installation
📦 Hadoop Ubuntu Installation Effortlessly set up Hadoop 3.3.6 on Ubuntu 20.04 with this guide! 🚀 Secure SSH keys 🔑, install Java ☕, configure environment variables ⚙️, and access web interfaces 🌐. Start your Hadoop journey today! 


# 🐧 Hadoop Setup on Ubuntu 20.04

## Prerequisites

- **OS**: Ubuntu 20.04
- **Hadoop Version**: 3.3.6

### Ensure you are in the `/home/{username}` directory

## 🛠️ System Update and Upgrade

1. **Refresh the local package index**:
   ```sh
   sudo apt update
   ```
2. **Upgrade installed packages to their latest versions**:
   ```sh
   sudo apt upgrade -y
   ```

## 🔑 SSH Key Setup

SSH keys are cryptographic key pairs used for secure authentication in Hadoop and other distributed systems. They enhance security by eliminating the need for passwords, enabling automated processes, securing data transfer, and facilitating cluster setup and configuration. SSH keys consist of a public key (shared) and a private key (kept secret) for secure communication between nodes in a Hadoop cluster.

1. **Install OpenSSH server and client**:
   ```sh
   sudo apt install openssh-server openssh-client -y
   ```
2. **Generate SSH key**:
   ```sh
   ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
   ```
3. **Add SSH key to authorized keys**:
   ```sh
   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/authorized_keys
   chmod 700 ~/.ssh
   ```
4. **Verify SSH setup**:
   ```sh
   ssh localhost
   ```

## ☕ Install Java

```sh
sudo apt install openjdk-11-jdk -y
```

## 📥 Download and Install Hadoop

1. **Download Hadoop**:
   ```sh
   wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
   ```
2. **Extract and move Hadoop to `/usr/local/hadoop`**:
   ```sh
   tar xzf hadoop-3.3.6.tar.gz
   sudo mv hadoop-3.3.6 /usr/local/hadoop
   ```

## ⚙️ Configure Environment Variables

1. **Edit `~/.bashrc`**:
   ```sh
   gedit ~/.bashrc
   ```
2. **Add the following lines at the end of the file**:
   ```sh
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
   export HADOOP_HOME=/usr/local/hadoop
   export HADOOP_INSTALL=$HADOOP_HOME
   export HADOOP_MAPRED_HOME=$HADOOP_HOME
   export HADOOP_COMMON_HOME=$HADOOP_HOME
   export HADOOP_HDFS_HOME=$HADOOP_HOME
   export HADOOP_YARN_HOME=$HADOOP_HOME
   export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
   export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
   export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
   export PDSH_RCMD_TYPE=ssh
   ```
3. **Apply the changes**:
   ```sh
   source ~/.bashrc
   ```

4. **Verify the installation**:
   ```sh
   hadoop version
   ```

## 📝 Configure Hadoop Files

### Navigate to the Hadoop configuration directory

```sh
cd /usr/local/hadoop/etc/hadoop
```

### a) `core-site.xml`

1. **Open `core-site.xml`**:
   ```sh
   gedit core-site.xml
   ```
2. **Add the following configuration**:
   ```xml
   <property>
     <name>fs.default.name</name>
     <value>hdfs://localhost:9000</value>
   </property>
   ```

### b) `hdfs-site.xml`

1. **Open `hdfs-site.xml`**:
   ```sh
   gedit hdfs-site.xml
   ```
2. **Add the following configuration**:
   ```xml
   <property>
     <name>dfs.replication</name>
     <value>1</value>
   </property>
   <property>
     <name>dfs.namenode.name.dir</name>
     <value>/home/{username}/hadoop2-dir/namenode-dir</value>
   </property>
   <property>
     <name>dfs.datanode.data.dir</name>
     <value>/home/{username}/hadoop2-dir/datanode-dir</value>
   </property>
   ```

### c) `mapred-site.xml`

1. **Open `mapred-site.xml`**:
   ```sh
   gedit mapred-site.xml
   ```
2. **Add the following configuration**:
   ```xml
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
   ```

### d) `yarn-site.xml`

1. **Open `yarn-site.xml`**:
   ```sh
   gedit yarn-site.xml
   ```
2. **Add the following configuration**:
   ```xml
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
     <value>${yarn.resourcemanager.hostname}:8032</value>
   </property>
   ```

### e) `hadoop-env.sh`

1. **Open `hadoop-env.sh`**:
   ```sh
   gedit hadoop-env.sh
   ```
2. **Add the following configuration**:
   ```sh
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
   ```

### f) `mapred-env.sh`

1. **Open `mapred-env.sh`**:
   ```sh
   gedit mapred-env.sh
   ```
2. **Add the following configuration**:
   ```sh
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
   ```

### g) `yarn-env.sh`

1. **Open `yarn-env.sh`**:
   ```sh
   gedit yarn-env.sh
   ```
2. **Add the following configuration**:
   ```sh
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
   ```

## 🚀 Final Steps

### Format HDFS

1. **Navigate to the Hadoop directory**:
   ```sh
   cd /usr/local/hadoop
   ```
2. **Format the HDFS**:
   ```sh
   hdfs namenode -format
   ```

### Start Hadoop Services

```sh
start-all.sh
```

### Access Hadoop Interfaces

- **NameNode**: [http://localhost:9870](http://localhost:9870)
- **ResourceManager**: [http://localhost:8088](http://localhost:8088)

### Stop Hadoop Services

```sh
stop-all.sh
```

---

🎉 **Hadoop setup complete successfully!** 🎉


🎉  Created by 0xA13H4Y
