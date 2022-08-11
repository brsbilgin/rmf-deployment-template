FROM ghcr.io/junhaochng/rmf_deployment_template/builder-rmf

SHELL ["bash", "-c"]

ENV NEURONBOT_RMF_FLEET_ADAPTER_CONTROL_TYPE=full_control
ENV NEURONBOT_RMF_FLEET_ADAPTER_FLEET_NAME=tinyRobotFleet
ENV NEURONBOT_RMF_FLEET_ADAPTER_NAV_GRAPH_FILE=/opt/rmf/install/rmf_demos_maps/share/rmf_demos_maps/maps/office/nav_graphs/1.yaml
ENV NEURONBOT_RMF_FLEET_ADAPTER_LINEAR_VELOCITY=0.5
ENV NEURONBOT_RMF_FLEET_ADAPTER_ANGULAR_VELOCITY=0.6
ENV NEURONBOT_RMF_FLEET_ADAPTER_LINEAR_ACCELERATION=0.75
ENV NEURONBOT_RMF_FLEET_ADAPTER_ANGULAR_ACCELERATION=2.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_FOOTPRINT_RADIUS=0.3
ENV NEURONBOT_RMF_FLEET_ADAPTER_VICINITY_RADIUS=1.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_DELAY_THRESHOLD=15.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_RETRY_WAIT=10.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_DISCOVERY_TIMEOUT=60.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_PERFORM_DELIVERIES=true
ENV NEURONBOT_RMF_FLEET_ADAPTER_PERFORM_LOOP=true
ENV NEURONBOT_RMF_FLEET_ADAPTER_PERFORM_CLEANING=true
ENV NEURONBOT_RMF_FLEET_ADAPTER_BATTERY_VOLTAGE=12.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_BATTERY_CAPACITY=24.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_BATTERY_CHARGING_CURRENT=5.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_MASS=20.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_INERTIA=10.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_FRICTION_COEFFICIENT=0.22
ENV NEURONBOT_RMF_FLEET_ADAPTER_AMBIENT_POWER_DRAIN=20.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_TOOL_POWER_DRAIN=0.0
ENV NEURONBOT_RMF_FLEET_ADAPTER_DRAIN_BATTERY=true
ENV NEURONBOT_RMF_FLEET_ADAPTER_RECHARGE_THRESHOLD=0.1
ENV NEURONBOT_RMF_FLEET_ADAPTER_SERVER_URI=ws://localhost:8001

RUN sed -i '$iros2 run rmf_fleet_adapter $NEURONBOT_RMF_FLEET_ADAPTER_CONTROL_TYPE --ros-args \ 
    -p fleet_name:=$NEURONBOT_RMF_FLEET_ADAPTER_FLEET_NAME \
    -p control_type:=$NEURONBOT_RMF_FLEET_ADAPTER_CONTROL_TYPE \ 
    -p nav_graph_file:=$NEURONBOT_RMF_FLEET_ADAPTER_NAV_GRAPH_FILE \
    -p linear_velocity:=$NEURONBOT_RMF_FLEET_ADAPTER_LINEAR_VELOCITY \
    -p angular_velocity:=$NEURONBOT_RMF_FLEET_ADAPTER_ANGULAR_VELOCITY \
    -p linear_acceleration:=$NEURONBOT_RMF_FLEET_ADAPTER_LINEAR_ACCELERATION \
    -p angular_acceleration:=$NEURONBOT_RMF_FLEET_ADAPTER_ANGULAR_ACCELERATION \
    -p footprint_radius:=$NEURONBOT_RMF_FLEET_ADAPTER_FOOTPRINT_RADIUS \
    -p vicinity_radius:=$NEURONBOT_RMF_FLEET_ADAPTER_VICINITY_RADIUS \
    -p use_sim_time:=$RMF_USE_SIM_TIME \
    -p delay_treshold:=$NEURONBOT_RMF_FLEET_ADAPTER_DELAY_THRESHOLD \
    -p retry_wait:=$NEURONBOT_RMF_FLEET_ADAPTER_RETRY_WAIT \
    -p discovery_timeout:=$NEURONBOT_RMF_FLEET_ADAPTER_DISCOVERY_TIMEOUT \
    -p perform_deliveries:=$NEURONBOT_RMF_FLEET_ADAPTER_PERFORM_DELIVERIES \
    -p perform_loop:=$NEURONBOT_RMF_FLEET_ADAPTER_PERFORM_LOOP \
    -p perform_cleaning:=$NEURONBOT_RMF_FLEET_ADAPTER_PERFORM_CLEANING \
    -p battery_voltage:=$NEURONBOT_RMF_FLEET_ADAPTER_BATTERY_VOLTAGE \
    -p battery_capacity:=$NEURONBOT_RMF_FLEET_ADAPTER_BATTERY_CAPACITY \
    -p battery_charging_current:=$NEURONBOT_RMF_FLEET_ADAPTER_BATTERY_CHARGING_CURRENT \
    -p mass:=$NEURONBOT_RMF_FLEET_ADAPTER_MASS \
    -p inertia:=$NEURONBOT_RMF_FLEET_ADAPTER_INERTIA \
    -p friction_coefficient:=$NEURONBOT_RMF_FLEET_ADAPTER_FRICTION_COEFFICIENT \
    -p ambient_power_drain:=$NEURONBOT_RMF_FLEET_ADAPTER_AMBIENT_POWER_DRAIN \
    -p tool_power_drain:=$NEURONBOT_RMF_FLEET_ADAPTER_TOOL_POWER_DRAIN \
    -p drain_battery:=$NEURONBOT_RMF_FLEET_ADAPTER_DRAIN_BATTERY \
    -p recharge_threshold:=$NEURONBOT_RMF_FLEET_ADAPTER_RECHARGE_THRESHOLD \
    -r __node:=${NEURONBOT_RMF_FLEET_ADAPTER_FLEET_NAME}_fleet_adapter' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
