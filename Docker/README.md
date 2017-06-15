# Docker 101

## What is Docker?

Allows the creation of light-weight containers that run within a host in a manner avoiding the overhead of a full-fledged virtual machine. The docker image specifies a base image (via the Dockerfile FROM option) to build upon along with a definition specifying the dependencies of a given application one is containerizing and a packaging mechanism to share the Docker images.


## What is Docker Compose?

Allows defining and running a multi-container Docker application. A docker-compose.yml defines the services pulled into the application (e.g., Docker images to include in the application).


## How is Docker being used?

* lightweight container for development/testing/debugging in a defined and easily repeatable environment in a team environment

* Further details see the [DI Docker Images README](https://github.com/ualbertalib/di_docker_images/blob/master/README.md)

## Requirements

* Details see the [DI Docker Images README](https://github.com/ualbertalib/di_docker_images/blob/master/README.md#requirements--deliverables)

## Software requirements

* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)
  * version 1.13 or higher as of 2017-05-10


## Docker: Usage

First usage steps:

1. Acquire the Docker image. There are two options:
    1. Download the prebuilt images from [ualibraries DockerHub](https://hub.docker.com/r/ualibraries/)
        * `docker pull ualibraries/${image_name}:${optional_tag}`
    2. Build from `Dockerfile` definition
        * `docker build -t ualibraries/${image_name}:${optional_tag} -f ${dockerfile} ${dockerfile_directory`

2. Run the Docker image creating a container

    * `docker run -d [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]`

After initial `docker run`,

* Exec shell within container
  * `docker exec -it ${container_id}  bash`

* `docker stop ${container_id}`

* `docker start ${container_id}`



## Docker-Compose: Usage

* Pull images associated with a service defined in a docker-compose.yml
  * `docker-compose -f docker-compose.yml pull`
* Setup application
  * `docker-compose -f docker-compose.yml up -d`
* Subsequent uses
  * `docker-compose -f docker-compose.yml stop`
  * `docker-compose -f docker-compose.yml start`
  * `docker-compose -f docker-compose.yml restart`


## Maintenance/Creation Tasks

### Creating from scratch

* Create a GitHub repo to contain the files
* Start with [README.md template](#readme-template)
* Populate the supporting Docker files (e.g, Dockerfile, docker-compose.yml)
* Build the Docker image from `Dockerfile` definition
* Test image
* Integrate with CI (e.g. Travis CI) [Example of CI in docker images](https://github.com/docker-library/ruby/blob/master/.travis.yml)
* Configure [Docker Hub](hub.docker.com) to [autobuild your image](#autobuilding-image-on-docker-hub)
* Test image from Docker Hub
* If applicable, test Docker Compose

<a name="autobuilding-image-on-docker-hub"></a>
### Autobuilding image on Docker Hub

* Readup on [Configure automated builds on Docker Hub](https://docs.docker.com/docker-hub/builds/). Below is a summary of this article.


#### Why Autobuilding the image vs manually provisioining the image?

* Images built in this way are built exactly as specified.
* The Dockerfile is available to anyone with access to your Docker Hub repository.
* Your repository is kept up-to-date with code changes automatically (Less manual work to update/maintain docker images).
* Better documentation as a result, you know exactly how that image was created and theres a link to the github repo as well.

#### How to Autobuild the image on dockerhub

* Make sure you have a account on docker hub and has been linked to your github account
* Instead of creating a docker repo, you can create an automated build (found under the same `Create` dropdown on dockerhub)
* Specify the locations and behavior of the builds and how to create different tags/versions of the images from your github repo
* Trigger the builds on dockerhub repo manually or by pushing code to the github repo to get our first image built and make sure everything is working
* Test image by pulling from Docker Hub
* If applicable, test Docker Compose

### Updating local container

To upgrade to a newer release of the image:

* download the updated Docker image:
  * `docker pull ualibraries\${CONTAINER_ID}:${TAG}`

* stop currently running image:
  * `docker stop ${container_id}`

* Removed the stopped container:
  * `docker rm -v ${container_id}`

* Start the updated Docker image:
  * `docker run ...`


### Updating local Docker Compose

To upgrade to a newer release of the image:

* download the updated Docker images defined in the docker-compose.yml:
  * `docker-compose -f docker-compose.yml pull`

* stop currently running services:
  * `docker-compose -f docker-compose.yml stop`

* Removed the stopped container:
  * `docker-compose -f docker-compose.yml rm`

* Start the updated Docker image:
  * `docker-compose -f docker-compose.yml up -d`


## Frequently used commands

* Docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
  * (reference](https://docs.docker.com/engine/reference/run/)

* Docker run: mount a host directory as a data volume in the container
  * `-v ${HOST_DIRECTORY}:${CONTAINER_DIR}`
  * overlays but does not remove pre-existing content in container [ref.](https://docs.docker.com/engine/tutorials/dockervolumes/)

* Docker run: map ports
  * `-p ${HOST_PORT}:${CONTAINER_PORT}`

* Docker run: give container a name as an alternate to UUID long or UUID short identifiers
  * `-name ${NAME} `

* Shell access
  * `docker exec -it ${container_id}  bash`

* Low-level container information
  * `docker inspect ${container_id}`

* Display container log files
  * `docker logs --details --follow ${container_id}`

* Remove containers and associated volumes
  * `docker rm --volumes`

* List containers
  * `docker ps --all --size`

* Network listing
  * `docker network ls`

* IP address of the container
  * `docker inspect {$CID} | grep IPAddress`

* Other Docker CLI commands
  * [Docker documentation](https://docs.docker.com/engine/reference/commandline/docker/)


* to see the container(s) logs
  * `docker-compose logs ${container_id}`

* to build the image(s) from scratch
  * `docker-compose build --no-cache ${container_id}`

* Allow a non-root user to administer Docker
  * add user to the `docker` group
  * warning, only add trusted users - [reference](https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface) - allows the user to share a directory between the Docker host and guest container without limiting access rights (i.e., it will have root level access to the shared directory). Requiring `sudo` to start Docker leaves a log trail.



## Terminology
  * Docker container versus image
    * image: created by the build process, stored in Docker Hub registry, inert, essentially a snapshot of a container
    * container: running instance of an image


<a name="readme-template">

## Proposed README.md template for DI Docker images

```
# Title describing what the DI Docker image is/does/contains


## What is this?

A paragraph or two describing the purpose/goal of this Docker project. What need does it fulfill?


## Requirements

What is required to work with this Docker container? What are the prerequisites?


## In this Docker Container

What is in the Docker Container? Aim, give the reader a brief idea at a high level what the Dockerfile builds without the user having to read and understand the Dockerfile. Reasoning for use the given base image?


## Usage

Audience: individual with little Docker experience or limited Linux admin experience. Include any special instructions otherwise link to the general [Developer Handbook Docker Usage Section](https://github.com/ualbertalib/Developer-Handbook/blob/master/docker/README.md#Usage)

### Container creation

Steps to run the container.

### Other usage instructions, if applicable

For example, how to run test tasks within the container or how to setup for debugging.


## Maintenance

Include maintenance tasks e.g., update Docker Hub

### Updating Docker Hub

* Associated Docker Hub repository URL
* Any special instructions on updating Docker Hub otherwise link to the general [docker stop, rm, pull new version, run notes](#Upgrading-local-container)

### Upgrading local container

Any special instructions on updating a local container otherwise link to the general [docker stop, rm, pull new version, run notes](#Upgrading-local-container)


## Frequently used commands

A list of frequently used commands specific to this image. Link to [Developer Handbook](https://github.com/ualbertalib/Developer-Handbook/blob/master/docker/README.md#Frequently-used-commands)

## Special notes / warnings / gotchas

Notes to leave to a future user/maintainer that might hightlights something counter-intuitive.


## Future considerations

To capture any proposed future work or future considerations.

```



## Notes around practice

* Take care around the use the Docker Hub ":latest" tag because it is "the last build/tag that ran without a specific tag/version specified" [reference](https://medium.com/@mccode/the-misunderstood-docker-tag-latest-af3babfd6375)

* link/depends_on in docker-compose to handle dependencies and determine the order of service start-up.
  * [links](https://docs.docker.com/compose/compose-file/compose-file-v2/#links)
  * [depends_on](https://docs.docker.com/compose/compose-file/compose-file-v2/#dependson)


## Special notes / warnings / gotchas



## Future considerations

* Docker Swarm for production deployments [Reference DI Docker Images #10](https://github.com/ualbertalib/di_docker_images/issues/10)
  * https://docs.docker.com/compose/production/
  * https://docs.docker.com/get-started/
  * https://github.com/docker/labs/tree/master/beginner (python app but very similar to a rails app)

* Atomic [Reference DI Docker Images #11](https://github.com/ualbertalib/di_docker_images/issues/11)

## References

### General

* Docker Get Started: https://docs.docker.com/get-started

* Docker: https://docs.docker.com/engine/

* Docker Compose Overview: https://docs.docker.com/compose/overview/

* Manage data in containers: https://docs.docker.com/engine/tutorials/dockervolumes/

* Docker Best Practices: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run

* Langemak, Jon. Docker Networking Cookbook : 60 Practical Recipes That Help You Gain Expertise with Docker Networking and Understand the Underlying Constructs That Make it All Work. <http://library.ualberta.ca/catalog/7639159>


