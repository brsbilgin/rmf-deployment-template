FROM ghcr.io/sharp-rmf/rmf-deployment/builder-rmf

SHELL ["bash", "-c"]

RUN sed -i '$iros2 run rmf_fleet_adapter door_supervisor' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
