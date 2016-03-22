FROM ubuntu:14.04
MAINTAINER wingerath wolfram@wingerath.org

# The used storm version:
ENV STORM_VERSION apache-storm-0.10.0

# derived parameters
ENV STORM_HOME /usr/share/storm
ENV STORM_LOCAL ${STORM_HOME}/storm-local

WORKDIR ${STORM_HOME}

# supervisor: worker ports
EXPOSE 6700 6701 6702 6703
# logviewer
EXPOSE 8000
# DRPC and remote deployment
EXPOSE 6627 3772 3773

# setting up config files
RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Install stuff
RUN \
   apt-get update -y && apt-get install -y \
   unzip \
   make \
   build-essential \
   uuid-dev \
   libtool \
   python python-dev python-distribute python-pip \
   pkg-config \
   autoconf

RUN alias python=python3

# Install Java 8
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y  software-properties-common && \
  add-apt-repository ppa:webupd8team/java -y && \
  apt-get update && \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java8-installer && \
  apt-get clean

# add startup script
ADD start-supervisor.sh ${STORM_HOME}/start-supervisor.sh
RUN chmod +x ${STORM_HOME}/start-supervisor.sh

ENTRYPOINT ["/usr/share/storm/start-supervisor.sh"]