#!/bin/bash
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-fleet-adapter && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-trajectory-visualizer && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-traffic-schedule && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-traffic-schedule-monitor && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-task-dispatcher && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-traffic-blockade && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-lift-supervisor && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-door-supervisor && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/rmf-building-map-server && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/builder-rmf && \
docker image pull ghcr.io/sharp-rmf/rmf-deployment/builder-rosdep
