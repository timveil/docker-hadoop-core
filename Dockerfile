FROM timveil/docker-hadoop-base:latest

LABEL maintainer="tjveil@gmail.com"

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV USER=root
ENV PATH=$HADOOP_HOME/bin/:$PATH

ARG HADOOP_VERSION=2.8.4
ARG HADOOP_DOWNLOAD_URL=https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ARG HADOOP_DOWNLOAD_DIR=/tmp/hadoop

RUN mkdir -pv $HADOOP_DOWNLOAD_DIR \
    && curl -fSL "$HADOOP_DOWNLOAD_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C $HADOOP_DOWNLOAD_DIR --strip-components=1 \
    && mv -v $HADOOP_DOWNLOAD_DIR /opt \
    && rm -rfv /tmp/hadoop.tar.gz \
    && rm -rfv $HADOOP_HOME/share/doc \
    && cp -v $HADOOP_CONF_DIR/mapred-site.xml.template $HADOOP_CONF_DIR/mapred-site.xml


# comment out some really gross env variables
# RUN sed -e '/^export HADOOP_DATANODE_OPTS/s/^/#/' -i $HADOOP_CONF_DIR/hadoop-env.sh
# RUN sed -e '/^export HADOOP_NAMENODE_OPTS/s/^/#/' -i $HADOOP_CONF_DIR/hadoop-env.sh
# RUN sed -e '/^export HADOOP_SECONDARYNAMENODE_OPTS/s/^/#/' -i $HADOOP_CONF_DIR/hadoop-env.sh

# Custom configuration goes here
ADD conf/httpfs-log4j.properties $HADOOP_CONF_DIR
ADD conf/kms-log4j.properties $HADOOP_CONF_DIR
ADD conf/log4j.properties $HADOOP_CONF_DIR
ADD conf/log4j-timeline.properties $HADOOP_CONF_DIR/timelineserver-config/log4j.properties
ADD conf/log4j-nodemanager.properties $HADOOP_CONF_DIR/nm-config/log4j.properties
ADD conf/log4j-resourcemanager.properties $HADOOP_CONF_DIR/rm-config/log4j.properties
ADD conf/logging.properties $JAVA_HOME/jre/lib
