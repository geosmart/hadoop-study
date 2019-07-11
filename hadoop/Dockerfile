# FROM openjdk:8-alpine
FROM ubuntu:xenial


# Refresh package lists
# RUN apk add net-tools bash curl
RUN apt update && apt-get install net-tools unzip bash curl default-jdk python nano -y

WORKDIR /opt

# Hadoop
RUN curl -L http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz -s -o - | tar -xzf -

RUN mv hadoop-3.1.1 hadoop

# spark
RUN curl -L http://ftp.unicamp.br/pub/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz -o - | tar -xzf -
RUN mv spark-2.4.3-bin-hadoop2.7 spark

# livy (spark rest server)
RUN curl http://ftp.unicamp.br/pub/apache/incubator/livy/0.5.0-incubating/livy-0.5.0-incubating-bin.zip -o livy-0.5.0-incubating-bin.zip
RUN unzip livy-0.5.0-incubating-bin.zip && mv livy-0.5.0-incubating-bin livy && rm livy-0.5.0-incubating-bin.zip

# hive
RUN curl -L http://ftp.unicamp.br/pub/apache/hive/hive-3.1.1/apache-hive-3.1.1-bin.tar.gz -s -o - | tar -xzf -

RUN mv apache-hive-3.1.1-bin hive


# copy configs
COPY hive/hive-site.xml           /opt/hive/conf/hive-site.xml
COPY etc/hadoop/core-site.xml     /opt/hadoop/etc/hadoop/core-site.xml
COPY etc/hadoop/hdfs-site.xml     /opt/hadoop/etc/hadoop/hdfs-site.xml
COPY etc/hadoop/yarn-site.xml     /opt/hadoop/etc/hadoop/yarn-site.xml
COPY etc/hadoop/httpfs-site.xml   /opt/hadoop/etc/hadoop/httpfs-site.xml
COPY livy/livy.conf               /opt/livy/conf/livy.conf

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
ENV LIVY_HOME           /opt/livy
ENV HADOOP_HOME         /opt/hadoop
ENV HADOOP_CONF_DIR     /opt/hadoop/etc/hadoop
ENV JAVA_HOME           /usr/lib/jvm/default-java/jre
ENV HIVE_HOME           /opt/hive

# path for binaries SPARK, HADOOP and HIVE
ENV PATH $PATH:$SPARK_HOME/bin/:$HADOOP_HOME/bin/:$HIVE_HOME/bin/:$LIVY_HOME/bin

RUN echo "JAVA_HOME=$JAVA_HOME" >> etc/hadoop/hadoop-env.sh 

RUN jar cv0f spark-libs.jar -C $SPARK_HOME/jars/ .

COPY entrypoint.sh entrypoint.sh

CMD [ "./entrypoint.sh" ]
