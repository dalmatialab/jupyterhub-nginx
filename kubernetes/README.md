# Jupyterhub

This repo contains Jupyterhub Helm chart for deploying on Kubernetes. Chart include pyspark with all requirments for connection to Spark master from jupyter notebook.

## Installation

Nodes where Jupyterhub needs to be deployed must be labeled. There are four labels namely, `jupyterhub`, `jupyterproxy`, `prepull` and `jupytersingleuser`. To label node use:

    $ kubectl label nodes node-list jupyterhub=true jupyterproxy=true jupytersingleuser=true prepull=true

Where:

 - `node-list` are nodes to label

To disable node selector just set `nodeselector` for hub, proxy, prepull in `values.yaml` to `false`. To disable `jupytersingleuser` nodeselector remove nodeselector section from `singleuserconfig`.  
`Prepull nodeselector` is used to select nodes where Jupyterhub images will be prepulled (if not set images will be prepulled on all possible nodes)
Before installation fill `values.yaml` and to install Helm chart run:

    $ helm install some-chart-name --namespace=some-namespace-name --create-namespace --timeout=3600s path-to-chart-directory

Where:

- `some-chart-name` is Helm chart name
- `some-namespace-name` is optional argument that defines Kubernetes and Helm namespace where chart will be installed
- `path-to-chart-directory` is chart directory

## Values

Possible values to configure inside `values.yaml` are: 

 - `image` - defines image name 
 - `imageTag` - defines image tag
 - `secret` - required variable. Secrets required for hub and proxy component. Generate them with `openssl rand -hex 32` (must be **different** for hub and proxy)
 - `serviceName` - defines Kubernetes service name for component
 - `replicas` - defines number of Pods (integer)
 - `nodeSelector` - defines node selector usage (boolean) and possible values are `true` and `false`
 - `nodePort` - defines service port where service can be accessed outside cluster
 - `timeout` - defines value of timeout for single-user config
 - `loglevel` - defines level of logging
 - `extraContainers` - defines additional containers. This is the field where you define desired Image name and tag.
 - `extraEnv` - defines ENV variable for the nginx Image. This is the field where you define port of the appplication.

In the example folder, You can find example of value file with aditional options for extraContainers. 

`Storage section` enables using costum volume mounts. To use it set `subsection enabled` to `true` and fill `volumeMounts` and `volumes` fields according to Kubernetes documentation.

`Singleuserconfig` is special section in `values.yaml` that defines configuration for `jupyter singleuser`. Possible values to change are:

  - `auth/admin/whitelist/users` - defines all users that can login into Jupyterhub
  - `auth/whitelist/users` - defines all users with admin rights
  - `auth/dummy/password` - one password for all users to login into Jupyterhub
  - `singleuser/extraEnv` - environmental variables for jupyter singleuser
  - `singleuser/image/name` - image name used to spawn jupyter singleuser
  - `singleuser/image/tag` - image tag to spawn jupyter singleuser
  - `singleuser/storage` - enables using costum volume mounts (fill fields according Kubernetes documentation)

To disable nodeselector remove `nodeSelector section ` from `singleuser subsection` in `values.yaml`.  
To use [costum storage](https://zero-to-jupyterhub.readthedocs.io/en/latest/jupyterhub/customizing/user-storage.html) modify storage section with following code and fill volumes and volumeMounts according to Kubernetes documentation:

    storage:
      extraVolumeMounts:
      extraVolumes:

To add more options for singleuser read [documentation](https://zero-to-jupyterhub.readthedocs.io/en/latest/jupyterhub/customization.html).

## Uninstallation

To full uninstall run:

    $ helm del some-chart-name -n some-namespace-name

Where:

- `some-chart-name` is Helm chart name for uninstall.
- `some-namespace-name` is optional argument that defines Helm namespace where chart is installed
