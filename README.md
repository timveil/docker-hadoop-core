# Docker Hadoop - Core (2.8.x)

`Dockerfile` responsible for extending `docker-hadoop-base` and installing and configuring core Hadoop components.  This image is extended by a number of other projects.

## Building the Image
```bash
docker build --no-cache -t timveil/docker-hadoop-core:2.8.x .
```

## Publishing the Image
```bash
docker push timveil/docker-hadoop-core:2.8.x
```

## Running the Image
```bash
docker run -it timveil/docker-hadoop-core:2.8.x
```