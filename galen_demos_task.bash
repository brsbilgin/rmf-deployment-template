#!/bin/bash
source ~/jh_rmf_ws/install/setup.bash && \
  export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp && \
  export CYCLONEDDS_URI=file:///home/jh/wg_cyclonedds.xml && \
  export ROS_DOMAIN_ID=15 && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_1 l2_4 -n 1 --use_sim_time && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_5 l2_7 -n 1 --use_sim_time && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_8 l2_10 -n 1 --use_sim_time && \
  sleep 100 && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_2 l2_3 -n 1 --use_sim_time && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_6 l2_6 -n 1 --use_sim_time && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_9 l2_9 -n 1 --use_sim_time && \
  sleep 100 && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_3 l2_1 -n 1 --use_sim_time && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_7 l2_5 -n 1 --use_sim_time && \
  ros2 run rmf_demos_tasks dispatch_patrol -p l1_10 l2_8 -n 1 --use_sim_time && \
  sleep 100 #&& \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_1 l1_3  -n 1 --use_sim_time && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_5 l1_7  -n 1 --use_sim_time && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_8 l1_10 -n 1 --use_sim_time && \
  # sleep 100 && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_3 l1_2 -n 1 --use_sim_time && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_6 l1_6 -n 1 --use_sim_time && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_9 l1_9 -n 1 --use_sim_time && \
  # sleep 100 && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_4 l1_1 -n 1 --use_sim_time && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_7 l1_5 -n 1 --use_sim_time && \
  # ros2 run rmf_demos_tasks dispatch_patrol -p l2_10 l1_8 -n 1 --use_sim_time && \
  # sleep 100
