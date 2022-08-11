FROM ghcr.io/junhaochng/rmf_deployment_template/builder-rmf

SHELL ["bash", "-c"]

RUN sed -i '$iros2 run rmf_fleet_adapter lift_supervisor' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
