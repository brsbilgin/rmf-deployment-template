# rmf-deployment

This repo provides a way to build, deploy and manage an RMF installation for CHART. This repo provides two methods of deployment, through [docker-compose.yml](docker-compose.yml), and through [Helm](https://helm.sh/) with [Kubernetes](https://kubernetes.io/). 

This repo evolved from [open-rmf/rmf_deployment_template](https://github.com/open-rmf/rmf_deployment_template). Credits to Akash et al. from OpenRobotics!

>The git version of RMF used will be the <code>main</code> branch of RMF, with  <code>ROS2 Galactic</code>. 

>The term **chart** in this repo means a helm chart

# File Structure

The site specific files and configurations such as the nav_graphs; building.yaml; and config.yamls are stored in two seperate locations. One for docker-compose deployment method and one for helm deployment method.

This repo is structured as -
- [rmf](rmf) - Contains Dockerfiles for deployment
  - [demos](rmf/demos) - Contains the site-specific configuration files for a deployment using Docker Compose. Config files include files like nav_graphs; building.yaml; and config.yamls
- [docker-compose.yml](docker-compose.yml) - Bringup instructions for a docker-compose bringup, uses the [env](deployment/docker-compose/env) file to store the environmental variables
- [rmf-deployment](rmf-deployment) - Contains the helm charts and templates 
  - [charts/rmf-core-modules/site-specific](rmf-deployment/charts/rmf-core-modules/site-specific) - Contains the site-specific configuration files for a deployment using Helm. Config files include files like nav_graphs; building.yaml; and config.yamls
- [rmf-simulation](rmf-simulation) - TO BE TESTED
- [rmf-web](rmf-web) - TO BE TESTED

We will be using the following tools -
- CI : [Github actions](https://github.com/features/actions)
- Container registry: [Github packages](https://github.com/features/packages)
- VM hosting: [AWS EC2](https://aws.amazon.com/ec2/)
- DNS: [AWS Route 53](https://aws.amazon.com/route53/)
- Kubernetes distribution: [k3s](https://k3s.io) 
- CD: [ArgoCD](https://argoproj.github.io/cd)

> ## Deployment methods, Docker or Kubernetes?
>This repo provides two ways of launching RMF, through docker-compose, or through kubernetes.
The <code>Docker</code> method is arguably more straight forward, you don't have to learn Kubernetes to run it.
However the <code>Kubernetes</code> method provides a way to revive things when they die, which they do.. frequently..

# Docker deployment
Follow the docker enginer installation instructions here. This should be all you need.
https://docs.docker.com/engine/install/ubuntu/
```
git clone https://github.com/sharp-rmf/rmf-deployment.git
chmod +x docker-compose-pull.bash # The docker images are already available at github.com/sharp-rmf/rmf-deployment 
./docker-compose-pull.bash
# docker-compose pull
docker-compose up
```
To Stop
```
docker-compose down
```
# Kubernetes deployment

Replace the <code>--flannel-iface</code> with the network interface you are using to connect to the internet
```
# Install k3s
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/k3sup
k3sup install --local --user ubuntu --cluster --k3s-extra-args '--flannel-iface=ens5 --no-deploy traefik --write-kubeconfig-mode --docker' --k3s-version v1.24.4+k3s1
export KUBECONFIG=$PWD/kubeconfig
helm install rmf-deployment rmf-deployment
```
## To Stop
```
helm uninstall rmf-deployment
k3sup-killall.sh && k3sup-uninstall.sh
```
## To Restart
```
k3sup install --local --user ubuntu --cluster --k3s-extra-args '--flannel-iface=ens5 --no-deploy traefik --write-kubeconfig-mode --docker' --k3s-version v1.24.4+k3s1
helm install rmf-deployment rmf-deployment
```
> Use the .helmignore file is used to specify files you don't want to include in your helm chart deployment.

## Helper commands
```
# Check that nodes are running
kubectl get pods --all-namespaces
# Check configmap is running
kubectl get cm
```
## To insert in a new building.yaml or edit an existing one:
1. Edit or replace the building.yaml in [this location](rmf-deployment/charts/rmf-core-modules/site-specific/building_yamls/) 
2. Ensure the building.yaml is included in the configmap, see [here](rmf-deployment/charts/rmf-core-modules/templates/config/building-configmap.yaml)
3. Kill the existing building map server and configmap which stores your building map with:

    ```kubectl kill pods rmf-building-map-server && kubectl kill cm building-configmap```
4. Spin up everything with: 

    ```helm upgrade rmf-deployment rmf-deployment```

## To insert in a floorplan png file or edit an existing one:
1. Add the png or replace it in [this location](rmf-deployment/charts/rmf-core-modules/site-specific/building_yamls/pics/) 
2. Ensure the png is included in the floorplan-configmap, see [here](rmf-deployment/charts/rmf-core-modules/templates/config/floorplan-configmap.yaml)
3. Kill the existing floorplan-configmap with:

    ```kubectl kill cm floorplan-configmap```
4. Spin up everything with: 

    ```helm upgrade rmf-deployment rmf-deployment```

## Environment Variables and Configurations

The site specific configurations are found in [rmf/demos](rmf/demos) and [rmf-deployment/charts/rmf-core-modules/site-specific](rmf-deployment/charts/rmf-core-modules/site-specific). The latter folder is simply a copy of the one at the base of the repo.
> Helm does not provide a way to pass files external to the chart during helm install. So for users to supply data, it must be loaded using helm install -f or helm install --set. TODO. Workaround for this. 

The environmental variables, such as map transformations, are set in the [deployment/docker-compose/env](deployment/docker-compose/env). An example of important environmental variables include:
* ROS_DOMAIN_ID
* RMW_IMPLEMENTATION
* RMF_USE_SIM_TIME
* FLEET_NAME
* RMF_FLEET_ADAPTER_NAV_GRAPH_FILE

Other important files are the <code>./rmf/site-specific-configs/building.yaml</code>, <code>./rmf/site-specific-configs/nav_graphs</code>, and the cyclonedds configs stored in the <code>./cyclonedds.xml</code>.

