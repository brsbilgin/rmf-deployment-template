FROM ghcr.io/sharp-rmf/rmf-deployment/builder-rmf

SHELL ["bash", "-c"]
WORKDIR /opt/rmf/src/lionsbot
COPY . /opt/rmf/src/lionsbot/
WORKDIR /opt/rmf
RUN python3 -m pip install websocket rel nudged

ENV RMF_FLEET_ADAPTER=fleet_adapter_leoscrub
ENV RMF_FLEET_ADAPTER_CONFIG_FILE=/opt/rmf/install/fleet_adapter_leoscrub/share/fleet_adapter_leoscrub/config.yaml
ENV RMF_FLEET_ADAPTER_NAV_GRAPH_FILE=/opt/rmf/src/lionsbot/fleet_adapter_leoscrub/maps/0.yaml
ENV RMF_FLEET_ADAPTER_SERVER_URI=ws://localhost:7878
ENV RMF_USE_SIM_TIME=false

# Build
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
  colcon build --packages-select fleet_adapter_leoscrub fleet_adapter_r3

RUN sed -i '$iros2 run $RMF_FLEET_ADAPTER fleet_adapter \
    -c $RMF_FLEET_ADAPTER_CONFIG_FILE \
    -n $RMF_FLEET_ADAPTER_NAV_GRAPH_FILE \
    --ros-args --remap use_sim_time:=$RMF_USE_SIM_TIME' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]