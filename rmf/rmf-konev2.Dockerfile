FROM ghcr.io/junhaochng/rmf_deployment_template/builder-rmf

ARG NETRC

COPY kone_lift_adapter.repos /root

ARG OVERLAY_WS=/opt/ros/overlay_ws

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y python3-pip && \
  pip3 install websocket websockets websocket-client requests

RUN mkdir -p $OVERLAY_WS/src
WORKDIR $OVERLAY_WS
RUN echo ${NETRC} > /root/.netrc
RUN vcs import src < /root/kone_lift_adapter.repos

COPY kone_lift_adapter $OVERLAY_WS/src/kone_lift_adapter

# install
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
  apt-get update && rosdep install -y \
  --from-paths \
  src/kone_lift_adapter \
  --ignore-src \
  && rm -rf /var/lib/apt/lists/*

# Build
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
  colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release\
  --mixin $OVERLAY_MIXINS

# source entrypoint setup
ENV OVERLAY_WS $OVERLAY_WS
RUN sed --in-place --expression \
  '$isource "$OVERLAY_WS/install/setup.bash"' \
  /ros_entrypoint.sh
RUN sed --in-place --expression \
  '$iexport RMW_IMPLEMENTATION=rmw_cyclonedds_cpp' \
  /ros_entrypoint.sh 
RUN sed --in-place --expression \
  '$iexport ROS_DOMAIN_ID=6' \
  /ros_entrypoint.sh 
RUN sed --in-place --expression \
  '$iexport  export CYCLONEDDS_URI=file:///wg_cyclonedds.xml' \
  /ros_entrypoint.sh 

# run launch file
CMD ["ros2", "run", "koneAdaptor", "koneNode"]
