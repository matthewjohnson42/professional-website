# Docker container for personal-website

A method for creating a Docker container for hosting a personal website.

The web server used to route traffic to the webpages is [Nginx](https://hub.docker.com/_/nginx).

Prerequisites for running the Docker container:

* Install of [Docker](https://docs.docker.com/install/). An install of docker-compose might also be necessary if running on Linux. 

* Install of [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

To start the container, run the following commands from the command line or terminal:

```
git clone https://github.com/matthewjohnson42/personal-website.git
cd personal-website/docker
docker-compose up --build
```

Open your web browser and type in ```localhost:8080```.
