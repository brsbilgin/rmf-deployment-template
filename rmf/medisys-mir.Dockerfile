FROM ghcr.io/sharp-rmf/rmf-deployment/builder-rmf

SHELL ["bash", "-c"]
WORKDIR /opt/rmf/src/medisys
COPY * /opt/rmf/src/medisys/
WORKDIR /opt/rmf
RUN python3 -m pip install urllib3 python_dateutil six certifi nudged

# Build
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
  colcon build --packages-select fleet_adapter_mircw mir_robot_client medisys_demos medisys_demos_maps

# ros2 run fleet_adapter_mircw fleet_adapter_mircw -c ./install/fleet_adapter_mircw/share/fleet_adapter_mircw/config.yaml -n ./install/rmf_demos_maps/share/rmf_demos_maps/maps/galen/nav_graphs/3.yaml -s ws://localhost:7878

ENV RMF_FLEET_ADAPTER_EXEC=fleet_adapter_mircw
ENV RMF_FLEET_ADAPTER_CONFIG_FILE=/opt/rmf/install/fleet_adapter_mircw/share/fleet_adapter_mircw/config.yaml
ENV RMF_FLEET_ADAPTER_NAV_GRAPH_FILE=/opt/rmf/install/rmf_demos_maps/share/rmf_demos_maps/maps/office/nav_graphs/0.yaml 
ENV RMF_FLEET_ADAPTER_SERVER_URI=ws://localhost:7878
ENV RMF_USE_SIM_TIME=false

RUN sed -i '$iros2 run fleet_adapter_mircw $RMF_FLEET_ADAPTER_EXEC \ 
    -c $RMF_FLEET_ADAPTER_CONFIG_FILE \
    -n $RMF_FLEET_ADAPTER_NAV_GRAPH_FILE \
    -s $RMF_FLEET_ADAPTER_SERVER_URI \
    --ros-args --remap use_sim_time:=$RMF_USE_SIM_TIME' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]