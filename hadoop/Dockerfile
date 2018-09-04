# FROM openjdk:8-alpine
FROM ubuntu:xenial


# Refresh package lists
# RUN apk add net-tools bash curl
RUN apt update && apt-get install net-tools bash curl default-jdk python -y

WORKDIR /opt

# Install Hadoop
RUN curl -L http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz -s -o - | tar -xzf -

RUN mv hadoop-3.1.1 hadoop

# download spark
RUN curl -L http://ftp.unicamp.br/pub/apache/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz -o - | tar -xzf -
RUN mv spark-2.3.1-bin-hadoop2.7 spark


# Setup
WORKDIR /opt/hadoop

ENV HDFS_DATANODE_USER root

ENV JAVA_HOME /usr/lib/jvm/default-java/jre
RUN echo "JAVA_HOME=$JAVA_HOME" >> etc/hadoop/hadoop-env.sh 

RUN mkdir -p /home/root/Hadoop/DataNode

COPY etc/hadoop/core-site.xml etc/hadoop/core-site.xml
COPY etc/hadoop/hdfs-site.xml etc/hadoop/hdfs-site.xml
COPY etc/hadoop/yarn-site.xml etc/hadoop/yarn-site.xml

RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf


ENV SPARK_HOME /opt/spark
RUN jar cv0f spark-libs.jar -C $SPARK_HOME/jars/ .
COPY spark/conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf

COPY data/ /data/ 
COPY entrypoint.sh entrypoint.sh
COPY pyspark-examples/ /pyspark-examples/

EXPOSE 9864 8088 9870 8042

ENTRYPOINT [ "./entrypoint.sh" ]

# ENTRYPOINT [ "bash" ]

