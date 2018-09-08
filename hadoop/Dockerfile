# FROM openjdk:8-alpine
FROM ubuntu:xenial


# Refresh package lists
# RUN apk add net-tools bash curl
RUN apt update && apt-get install net-tools bash curl default-jdk python -y

WORKDIR /opt

# download Hadoop
RUN curl -L http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz -s -o - | tar -xzf -

RUN mv hadoop-3.1.1 hadoop

# download spark
RUN curl -L http://ftp.unicamp.br/pub/apache/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz -o - | tar -xzf -
RUN mv spark-2.3.1-bin-hadoop2.7 spark

# download hive
RUN curl -L http://ftp.unicamp.br/pub/apache/hive/hive-3.1.0/apache-hive-3.1.0-bin.tar.gz -s -o - | tar -xzf -

RUN mv apache-hive-3.1.0-bin hive


# copy configs
COPY hive/hive-site.xml         /opt/hive/conf/yarn-site.xml
COPY etc/hadoop/core-site.xml   /opt/hadoop/etc/hadoop/core-site.xml
COPY etc/hadoop/hdfs-site.xml   /opt/hadoop/etc/hadoop/hdfs-site.xml
COPY etc/hadoop/yarn-site.xml   /opt/hadoop/etc/hadoop/yarn-site.xml

# Setup
WORKDIR /opt/hadoop


RUN mkdir -p /home/root/Hadoop/DataNode

# disable ipv6
RUN echo "net.ipv6.conf.all.disable_ipv6 = 1"     >>   /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6 = 1" >>   /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6 = 1"      >>   /etc/sysctl.conf

# env vars
ENV HDFS_DATANODE_USER  root
ENV SPARK_HOME          /opt/spark
ENV HADOOP_HOME         /opt/hadoop
ENV HADOOP_CONF_DIR     /opt/hadoop/etc/hadoop/
ENV JAVA_HOME           /usr/lib/jvm/default-java/jre
ENV HIVE_HOME           /opt/hive

# path for binaries SPARK, HADOOP and HIVE
ENV PATH $PATH:$SPARK_HOME/bin/:$HADOOP_HOME/bin/:$HIVE_HOME/bin/

RUN echo "JAVA_HOME=$JAVA_HOME" >> etc/hadoop/hadoop-env.sh 

RUN jar cv0f spark-libs.jar -C $SPARK_HOME/jars/ .
COPY spark/conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf

COPY data/ /data/ 
COPY entrypoint.sh entrypoint.sh
COPY pyspark-examples/ /pyspark-examples/


ENTRYPOINT [ "./entrypoint.sh" ]

# ENTRYPOINT [ "bash" ]

