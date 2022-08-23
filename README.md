# rmf-deployment

This repo focuses on launching RMF through Dockerfiles, the version of RMF used will be the <code>main</code> branch of RMF. This repo will be using <code>ROS2 Galactic</code>.

To launch RMF, please refer to the <code>docker-compose.yml</code> and the <code>.env</code> file.

### Environment Variables and Configurations

The environmental variables, such as map transformations are set in the <code>.env</code> file. The <code>.env</code> file is expected to be changed during a demo/ deployment. 

For example, <code>.env</code> stores important environmental variables  such as:
* ROS_DOMAIN_ID
* RMW_IMPLEMENTATION
* RMF_USE_SIM_TIME
* FLEET_NAME
* RMF_FLEET_ADAPTER_NAV_GRAPH_FILE

Other important files are the <code>./rmf/demos/building.yaml</code>, <code>./rmf/demos/nav_graphs</code>, and the cyclonedds configs stored in the <code>./cyclonedds.xml</code>.
## Build and run RMF
```
git clone https://github.com/sharp-rmf/rmf-deployment.git
chmod +x docker-compose-pull.bash # The docker images are already available at github.com/sharp-rmf/rmf-deployment 
# docker-compose pull
docker-compose up
```