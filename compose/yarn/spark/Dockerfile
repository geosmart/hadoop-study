FROM ubuntu:xenial

# Refresh package lists
RUN apt-get update --fix-missing

RUN apt install curl wget net-tools default-jre python -y

WORKDIR /opt

# download hadoop
RUN curl -L http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz -o - | tar -xzf -
RUN mv hadoop-3.1.1 hadoop

# download spark
RUN curl -L http://ftp.unicamp.br/pub/apache/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz -o - | tar -xzf -
RUN mv spark-2.3.1-bin-hadoop2.7 spark


ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

# Setup
WORKDIR /opt/hadoop

RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> etc/hadoop/hadoop-env.sh 

RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

COPY etc/hadoop/core-site.xml etc/hadoop/core-site.xml

WORKDIR /opt/spark
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" , "bash" ]
