![example workflow](https://github.com/dalmatialab/jupyterhub-nginx/actions/workflows/main.yml/badge.svg)

# Supported tags and respective Dockerfile links

 - [1.0-rc-1](https://github.com/dalmatialab/jupyterhub-nginx/blob/c5653eac908ab85415efd9363c31dd10233b6d37/Dockerfile)

# What is Nginx ?
[Nginx](https://hub.docker.com/_/nginx) is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage. It is licensed under the 2-clause BSD-like license and it runs on Linux, BSD variants, Mac OS X, Solaris, AIX, HP-UX, as well as on other *nix flavors. It also has a proof of concept port for Microsoft Windows.*

<img src="https://github.com/dalmatialab/jupyterhub-nginx/blob/47946e5066314ad1dd0407a46ea6c8d252dd41b9/logo.png" width="450" height="200">

# Why Nginx with JupyterHub?

The aim of this project is to modify [Jupyterhub](https://github.com/dalmatialab/jupyterhub) to deploy containerized application instead of standard Jupyter Notebook server. Simplified, when a user logs into Jupyterhub, it creates a single-user instance of Jupyter Notebook, and redirects the user to that instance by the user's credentials (/user/username). To find more about how Jupyterhub works, please read the official [Documentation](https://jupyterhub.readthedocs.io/en/stable/reference/technical-overview.html).

**This configuration is compatible only with deployment known as "Zero to JupyterHub with Kubernetes" !!**

Deployment of the Jupyterhub in Kubernetes is achieved by using [Helm charts](https://github.com/dalmatialab/jupyterhub-nginx/tree/main/kubernetes). Default configuration of the Jupyterhub is consisted of the Jupyterhub pod, [Configurable http proxy](https://github.com/jupyterhub/configurable-http-proxy) pod and multiple single-user (Notebook server) pods. A single-user pod is consisted of one container, but there is an option to insert additional containers in that pod. 

The idea is to **replace the Notebook server in the single-user pod with the Nginx server** that will be used to redirect requests to the desired application (inserted into Pod by using an additional container option). Mentioned nginx will be used as a reverse proxy, and only parameter that **needs to be defined is the PORT of the desired application**, since containers in Pod can communicate using localhost. 

## Environment variables

**APP\_PORT**

This is variable that specifies the PORT number of the desired application. Default value is 5000.

## Note

For this configuration, we decided to keep source code of the Jupyterhub, therefore we had to adjust Nginx server. By default, Jupyter Notebook server uses port 8888, and it is accessed (thanks to configurable-http proxy and OAUTH) by the ENV variable passed from the hub. Simplified, this variable is just an URL path (/user/username) that matches the user's credentials, also this variable shouldn't be changed. Having in mind this, [Reverse proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) is configured to use port 8888, and to pass all requests (that match certain path) to the localhost:APP_PORT.
 
