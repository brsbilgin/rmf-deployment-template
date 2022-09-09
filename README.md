# rmf-deployment

This repo provides a way to build, deploy and manage an RMF installation for CHART. This repo provides two methods of deployment, through [docker-compose.yml](docker-compose.yml), and through [Helm](https://helm.sh/) with [Kubernetes](https://kubernetes.io/). 

This repo evolved from [open-rmf/rmf_deployment_template](https://github.com/open-rmf/rmf_deployment_template). Credits to Akash et al. from OpenRobotics!

>The git version of RMF used will be the <code>main</code> branch of RMF, with  <code>ROS2 Galactic</code>. 

>The term **chart** in this repo means a helm chart

## File Structure

This repo is structured as -
- [rmf](rmf) - Contains Dockerfiles for deployment
- [deployment](deployment) - Contains the different methods of deployment. 
  - [deployment/docker-compose](deployment/docker-compose/) - Contains the [docker-compose.yml](deployment/docker-compose/docker-compose.yml) and [env](deployment/docker-compose/env) file to co-ordiante bringup
  - [deployment/helm](deployment/helm/) - Contains the helm chart and templates 
- [site-specific-configs](site-specific-configs) at the root dir, and  [site-specific-configs](deployment/helm/charts/rmf-core-modules/site-specific-configs) in the Helm folder - Contains deployment specific files, i.e. For **Galen**, the [building.yaml](site-specific-configs/galen/galen.building.yaml) and [nav_graphs](site-specific-configs/galen/nav_graphs/)
- [rmf-simulation](rmf-simulation) - TO BE TESTED
- [rmf-web](rmf-web) - TO BE TESTED

We will be using the following tools -
- CI : [Github actions](https://github.com/features/actions)
- Container registry: [Github packages](https://github.com/features/packages)
- VM hosting: [AWS EC2](https://aws.amazon.com/ec2/)
- DNS: [AWS Route 53](https://aws.amazon.com/route53/)
- Kubernetes distribution: [k3s](https://k3s.io) 
- CD: [ArgoCD](https://argoproj.github.io/cd)

> ### Deployment methods, Docker or Kubernetes?
>This repo provides two ways of launching RMF, through docker-compose, or through kubernetes.
The <code>Docker</code> method is arguably more straight forward, you don't have to learn Kubernetes to run it.
However the <code>Kubernetes</code> method provides a way to revive things when they die, which they do.. frequently..

## Docker deployment
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
## Kubernetes deployment

Replace the <code>--flannel-iface</code> with the network interface you are using to connect to the internet
```
# Install k3s
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/k3sup
k3sup install --local --user ubuntu --cluster --k3s-extra-args '--flannel-iface=wlp0s20f3 --no-deploy traefik --write-kubeconfig-mode --docker' --k3s-version v1.24.4+k3s1
export KUBECONFIG=$PWD/kubeconfig
helm install rmf-deployment ./deployment/helm
```
To Stop
```
helm uninstall rmf-deployment
k3sup-killall.sh && k3sup-uninstall.sh
```
> Use the .helmignore file is used to specify files you don't want to include in your helm chart deployment.

Helper commands
```
# Check that nodes are running
kubectl get pods --all-namespaces
# Check configmap is running
kubectl get cm

kubectl describe cm lvl5-floorplan-configmap
kubectl describe cm lvl1-floorplan-configmap
kubectl get configmaps lvl5-floorplan-configmap -o yaml > lvl5-floorplan-configmap.yaml

kubectl exec -it rmf-building-map-server -- /bin/bash
```
To pump in a new building.yaml file
```
kubectl create configmap building-configmap --from-file=YOURPATH/galen.building.yaml
kubectl get configmaps building-configmap -o yaml > building-configmap.yaml
# Place the new yaml into the configurations folder
```
To pump in the floorplan png files
```
kubectl create configmap floorplan-configmap --from-file=YOURPATH/galen.png
kubectl get configmaps floorplan-configmap -o yaml > floorplan-configmap.yaml
# Place the new yaml into the configurations folder
```

## Environment Variables and Configurations

The site specific configurations are found in [site-specific-configs](site-specific-configs) and [deployment/helm/charts/rmf-core-modules/site-specific-configs](deployment/helm/charts/rmf-core-modules/site-specific-configs). The latter folder is simply a copy of the one at the base of the repo.
> Helm does not provide a way to pass files external to the chart during helm install. So for users to supply data, it must be loaded using helm install -f or helm install --set. TODO. Workaround for this. 

The environmental variables, such as map transformations, are set in the [deployment/docker-compose/env](deployment/docker-compose/env). An example of important environmental variables include:
* ROS_DOMAIN_ID
* RMW_IMPLEMENTATION
* RMF_USE_SIM_TIME
* FLEET_NAME
* RMF_FLEET_ADAPTER_NAV_GRAPH_FILE

Other important files are the <code>./rmf/site-specific-configs/building.yaml</code>, <code>./rmf/site-specific-configs/nav_graphs</code>, and the cyclonedds configs stored in the <code>./cyclonedds.xml</code>.

