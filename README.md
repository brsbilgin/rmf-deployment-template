# rmf-deployment

This repo focuses on launching RMF through Dockerfiles, the version of RMF used will be the <code>main</code> branch of RMF. The main branch will be using <code> ROS2 Galactic </code>.

During deployment, for RMF core, only the stuff in the <code>rmf</code> needs to be executed.

### Environment Variables and Configurations

The environmental variables, such as map transformations are set in the <code>.env</code> file. It is expected to change the <code>.env</code> during a demo/ deployment. The file contains important environmental variables such as:
* ROS_DOMAIN_ID
* RMW_IMPLEMENTATION
* RMF_USE_SIM_TIME
* ROS_DOMAIN_ID
* ROS_DOMAIN_ID

Other important files are the <code>rmf/demos/building.yaml</code>, <code>rmf/demos/nav_graphs</code>, and the cyclonedds configs stored in the <code>cyclonedds.xml</code>.
## Build and running RMF
```
git clone https://github.com/sharp-rmf/rmf-deployment.git
docker-compose build
docker-compose up
```