FROM ghcr.io/junhaochng/rmf_deployment_template/builder-rmf

SHELL ["bash", "-c"]

ENV BUILDING_CONFIG_FILE_MOUNTPATH=/opt/rmf/src/demonstrations/rmf_demos/rmf_demos_maps/maps/office/office.building.yaml

RUN sed -i '$iros2 run rmf_building_map_tools building_map_server $BUILDING_CONFIG_FILE_MOUNTPATH' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
