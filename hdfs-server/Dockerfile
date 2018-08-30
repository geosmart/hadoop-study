FROM ubuntu:xenial

# Refresh package lists
RUN apt-get update

RUN apt install curl -y

WORKDIR /opt

# Install Hadoop
RUN curl -L http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz -s -o - | tar -xzf -

RUN mv hadoop-3.1.1 hadoop

RUN apt install default-jre -y


# Setup
WORKDIR /opt/hadoop

COPY etc/hadoop/core-site.xml etc/hadoop/core-site.xml
COPY etc/hadoop/hdfs-site.xml etc/hadoop/hdfs-site.xml
COPY ssh-setup.sh ssh-setup.sh


ENV HDFS_NAMENODE_USER root
ENV HDFS_DATANODE_USER root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV YARN_RESOURCEMANAGER_USER root
ENV YARN_NODEMANAGER_USER root

RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> etc/hadoop/hadoop-env.sh 

RUN apt-get install openssh-client openssh-server pdsh net-tools -y
RUN chmod +x ssh-setup.sh && ./ssh-setup.sh
RUN echo "ssh" > /etc/pdsh/rcmd_default


ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

COPY start.sh start.sh
RUN chmod +x start.sh
RUN mkdir -p /home/root/Hadoop/DataNode
RUN mkdir -p /home/root/Hadoop/NameNode

EXPOSE 9870
RUN ./bin/hdfs namenode -format

# ./start.sh

# ENTRYPOINT ["bash"]


RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf


CMD service ssh start \
  && ./sbin/start-dfs.sh \
  # && ./sbin/hadoop-daemon.sh start portmap \
  # && ./sbin/hadoop-daemon.sh start nfs3 \
  && bin/hdfs dfs -chown -R dr.who:dr.who / \
  && bash


