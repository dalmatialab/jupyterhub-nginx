# Supported tags and respective Dockerfile links

 - [1.0-rc-1]()

# What is Nginx ?
[Nginx](https://hub.docker.com/_/nginx) is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage. It is licensed under the 2-clause BSD-like license and it runs on Linux, BSD variants, Mac OS X, Solaris, AIX, HP-UX, as well as on other *nix flavors. It also has a proof of concept port for Microsoft Windows.*

<img src="https://github.com/dalmatialab/jupyterhub-nginx/blob/47946e5066314ad1dd0407a46ea6c8d252dd41b9/logo.png" width="200" height="200">

# Why Nginx with JupyterHub?

Aim of this project is to modify [Jupyterhub](https://github.com/dalmatialab/jupyterhub) to deploy containerized application instead of standard Jupyter Notebook server. Simplified, when user logs into Jupyterhub, it creates single-user instance of Jupyter Notebook, and redirects user to that instance by using user's credenitals (/user/username). To find more about how Jupyterhub works, please read the official [Documentation](https://jupyterhub.readthedocs.io/en/stable/reference/technical-overview.html).

**This configuration is compatible only with deployment known as "Zero to JupyterHub with Kubernetes" !!**

Role of the Nginx in this configuration is to replace Jupyter Notebook server that is spinning on port 8888. So, nginx server is deployed as reverse proxy that also spins on the port 8888, and its purpouse is to redirect users requests to their applications. JupyterHub includes option to run aditional containers inside of the single-user instance pod, and this option is used to deploy desired applications. In default configuration, there is JupyterHub that **spawns single-user instances consisted of single-container pod** (Notebook server). On the other hand, in this configuration there is JupyterHub that **spawns single-user instances consisted of multi-container pod** (Nginx server and user applications). 

## Environment variables

**APP\_PORT**

This is variable that specifies the PORT number of the desired application. Default value is 5000.

## Note

 
