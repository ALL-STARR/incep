*This project has been created as part of the 42 curriculum by thomvan-*

### Description
Inception is a 42 project where the goal is to build a web infrastructure using an architecture of Docker container services. Each one of them isolated in their own container and orchestrated by a Docker-compose file.
We need to :
- Create custom Docker images using Dockerfiles
- Deploy multiple services (Wordpress, Mariadb, NGINX)
- Manage persistent volumes
- Setup a container network
- Configure environment variables
- Secure the website through TLS certificate
- Use Docker-compose to orchestrate the services

### Instructions
To run and setup the project a script is used which can be launched using the Makefile
- make => will start the script, installing the different containers if they are not yet installed and then start each service
- make blank-start => will uninstall and delete volumes to reinstall and restart the services
- make clean =>will uninstall services and delete volumes

### Resources
- Docker documentation on Docker official website https://docs.docker.com/get-started/
- "how to run Nginx Easily in Docker " youtube video by Thomas Wilde
- "Docker Setup for local Worpress Development" youtuve video by Wazoo Web Bytes
- Mariadb documentation https://mariadb.com/docs
- grademe.fr/inception
##### use of AI
- Ai was mainly used to help generate the scripts and get deeper understanding of certain subjects.


### Project description
NGINX is used to handle outside connections and redirect requests, it can serve static pages or handle cgi by redirecting to the Wordpress container. It is the only container connected to the internet.

Wordpress is a content management system software that let's you create, edit and manage a website. It handles the CGI.

And Mariadb is a database for the website
The three containers are connected together through an isolated docker network which allows communication between them.

- Virtual machine vs Docker
		Dockers are lighter and faster to build environment but share the OS kernel of the host while Virtual machines are completely isolated but are heavier and slower to deploy
- Secrets vs environment Variables
		Secrets are an encrypted, acces-controlled way to store data while environment are easy to access and not secure variables
- Docker Network vs Host Network
		Docker network isolates containers behind a virtual network and host network just uses the host network
- Docker Volumes vs Bind Mounts
		Docker volumes are managed by docker and are good for portability, automatic management and backups while bind mounts are a direct map of a host folder into a container


