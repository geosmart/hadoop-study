FROM ubuntu:xenial

# Refresh package lists
RUN apt-get update --fix-missing

RUN apt install curl -y

WORKDIR /opt

# Install Hadoop
RUN curl -L http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz -s -o - | tar -xzf -

RUN mv hadoop-3.1.1 hadoop

RUN apt install default-jre -y


# Setup
WORKDIR /opt/hadoop

ENV HDFS_DATANODE_USER root

RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> etc/hadoop/hadoop-env.sh 

RUN apt-get install openssh-client openssh-server pdsh net-tools -y

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre


RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

COPY entrypoint.sh entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" , "bash" ]
# ENTRYPOINT [ "bash" ]
