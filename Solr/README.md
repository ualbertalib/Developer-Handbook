# Docker image of solr for hydra use

## What is this?

This is instruction on how to use latest official solr docker image with hydra applications


## Requirements

1. [Install Docker](https://docs.docker.com/engine/installation/)
2. Local directory with all config files required to create new solr core {local_config_dir}

## Usage

1. Download latest solr image
  ```
  docker pull solr:latest
  ```

1. Run docker image mapping docker port to localhost and mounting local config diretory into docker /config
   ```
   docker run -d -p 8983:8983 -v{local_config_dir}:/config docker ualbertalib/solr_hydra solr-precreate mycore /config
   ```

2. using docker-compose
   ```
   docker run -d -p 8983:8983 docker ualbertalib/solr_hydra solr-precreate mycore /config
   solr:
    image: ualbertalib/solr_hydra
    volumes:
      - solr:/opt/solr/server/solr
      - {local_config_dir}:/config
    entrypoint:
      - docker-entrypoint.sh
      - solr-precreate
      - my-hydra-core
      - /config
    ports:
      - 8983:8983
   ```

3. Access solr via web interface
    * [http://localhost:8983](http://localhost:8983)


## Maintenance

This is official solr image we do not maintain it.


## Frequently used commands ##

* Link to [Developer Handbook](https://github.com/ualbertalib/Developer-Handbook/blob/master/docker/README.md#Frequently-used-commands)
