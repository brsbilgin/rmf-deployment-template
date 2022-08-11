#-----------------------
# Stage 1 - Dependencies
#-----------------------

FROM ros:galactic AS builder

RUN apt-get update \
  && apt-get install -y \
    cmake \
    curl \
    git \
    python3-colcon-common-extensions \
    python3-vcstool \
    qt5-default \
    wget \
    python3-pip \
  && pip3 install flask-socketio fastapi uvicorn \
  && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# setup sources.list
RUN . /etc/os-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-latest.list

WORKDIR /opt/rmf
RUN mkdir src
RUN rosdep update --rosdistro $ROS_DISTRO

# This replaces: wget https://raw.githubusercontent.com/open-rmf/rmf/main/rmf.repos
ENV DEBIAN_FRONTEND=noninteractive
COPY rmf.repos rmf.repos
RUN vcs import src < rmf.repos \
    && apt-get update \
    && apt-get upgrade -y \
    && rosdep update \
    && rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -yr \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get install -y ignition-edifice \
    && rm -rf /var/lib/apt/lists/*