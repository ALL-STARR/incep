### Setup

##### installing docker

1. Install required packages
~~~
sudo apt update
sudo apt install ca-certificates curl gnupg
~~~

2. Add Docker’s official GPG key
~~~
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
~~~

3. Add the Docker APT repository
~~~
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
~~~

4. Update package lists
~~~
sudo apt update
~~~

5. Install Docker Engine
~~~
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
~~~

6. Enable and start Docker
~~~
sudo systemctl enable --now docker
~~~

7. Test Docker
~~~
sudo docker run hello-world
~~~

To have the docker volumes on the host we need to create /etc/docker/daemon.json and write 
{
	"data-root": "/home/thomvan-/data"
}

and then restart it with sudo systemctl restart docker

##### secrets
Secrets must be files containing only the info needed (e.g password, key etc..) their location is defined in the docker-compose file under secrets.
They are associated to the containers under their respective sections of the docker compose

##### configuration files
Configuration files are specific to each container. They are here located in the conf folder of each service folder in requirements and then copied into the right location through the Dockerfiles

##### building and launching
The Makefile launches a custom script that can take --blank-start (to restart from scratch), --clean (to deleted volumes and data) or no argument.
	e.g You can make --blank-start or bash ./run_docker.sh --blank-start
The script builds the docker-compose but you can also bypass it by doing "sudo docker compose up"
##### Data
The data is stored into two volumes on host the machine. Their directory is here created through the script and defined in .env file. Their are then associated to the containers in the Docker-compose file. 

##### useful commands 
docker version
	Shows Docker client and engine versions

docker info
	Shows the global state of Docker

docker ps
	Shows a list of running dockers

docker ps -a
	lists all containers even the ones not running 

docker start <name>
	restart an existing docker

docker stop <name>
	stops an active container

docker rm <name>
	remove a stopped container

docker logs <name>
	Shows container log

docker run [options] image
	Runs a container from an image with options 

##### Docker-Compose commands
`docker-compose up`
	run all the services mentioned in the docker compose

`docker-compose up -d`
	same but in background

`docker-compose down`
	stops services and cleans optional networks and volumes

`docker-compose build`
	Build the dockers images from the Dockerfiles

`docker-compose logs`
	shows the logs

`docker-compose exec`
	executes a command in a running container

`docker-compose up --build`
	Starts all services and rebuilds the image if there was a modification
