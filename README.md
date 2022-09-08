# rmf-deployment

This repo focuses on launching RMF through Dockerfiles, the version of RMF used will be the <code>main</code> branch of RMF. This repo will be using <code>ROS2 Galactic</code>.

The key difference is that this repo provides a way to load the building.yaml, nav_graphs, and site pictures onto your deployments

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
## Deployment methods, Docker or Kubernetes?
This repo provides two ways of launching RMF, through docker-compose, or through kubernetes.
The <code>Docker</code> method is arguably more straight forward, you don't have to learn Kubernetes to run it.
However the <code>Kubernetes</code> method provides a way to revive things when they die, which they do.. frequently..

### Docker deployment
Follow the docker enginer installation instructions here. This is about all you need.
https://docs.docker.com/engine/install/ubuntu/
```
git clone https://github.com/sharp-rmf/rmf-deployment.git
chmod +x docker-compose-pull.bash # The docker images are already available at github.com/sharp-rmf/rmf-deployment 
# docker-compose pull
docker-compose up
```

### Kubernetes deployment

Replace the <code>--flannel-iface</code> with the network interface you are using to connect to the internet
```
# Install k3s
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/k3sup
k3sup install --local --user ubuntu --cluster --k3s-extra-args '--flannel-iface=wlp0s20f3 --no-deploy traefik --write-kubeconfig-mode --docker' --k3s-version v1.24.4+k3s1
export KUBECONFIG=$PWD/kubeconfig
helm install rmf-deployment rmf-deployment
```
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