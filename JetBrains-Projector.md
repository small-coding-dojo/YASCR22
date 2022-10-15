# Deploy JetBrains Projector Docker Containers as Remote IDE in Google Cloud Run

<!-- doctoc --maxlevel 2 $HOME/source/small-coding-dojo/YASCR22/JetBrains-Projector.md -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Overview](#overview)
- [1. Run Projector Container Locally](#1-run-projector-container-locally)
- [2. Create a Google Artifact Registry and a Docker Repository](#2-create-a-google-artifact-registry-and-a-docker-repository)
- [3. Deploy the Container To Google CloudRun](#3-deploy-the-container-to-google-cloudrun)
- [Alternatives to JetBrains Projector](#alternatives-to-jetbrains-projector)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Overview

Idea: We deploy the required number of [JetBrains Projector Docker Containers](https://github.com/JetBrains/projector-docker) to [Google CloudRun](https://console.cloud.google.com/run).

The following [quickstart instructions for Google Cloud](https://cloud.google.com/run/docs/quickstarts?hl=en) apply:

- [Store Docker container images in Artifact Registry](https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images)
- [Deploying container images to Cloud Run](https://cloud.google.com/run/docs/deploying?hl=en)

## 1. Run Projector Container Locally

### Pull the Projector Container from JetBrains

Follow the instructions in [JetBrains Projector / Run JetBrains IDE](https://github.com/JetBrains/projector-docker#run-jetbrains-ide-in-docker) in Docker and pull from "Space".

```ad-important
Configure Docker such, that it gives at least 8GB RAM to a docker container.
```

```shell
docker pull registry.jetbrains.team/p/prj/containers/projector-idea-c

docker run --rm -p 8887:8887 -it --name projector-idea-c registry.jetbrains.team/p/prj/containers/projector-idea-c
```

```ad-info
Note, that the image will be slow on an Apple Silicon based mac, because it uses the `amd64` platform. At the time of writing, `arm64v8` was not available.
```

### Building the JetBrains Projector Docker Container Locally

```ad-warning
Please note that this section of the guide has never been completed successfully. Reasons are:

- I had some trouble creating the Docker image on an Apple Silicon based mac
- I have started to build the Docker image following the updated instructions below, but this took more than 1 hour. I have aborted the build and pulled from [registry.jetbrains.team/p/prj/containers/projector-*](https://github.com/JetBrains/projector-docker) instead
```

To build and test the [JetBrains Projector Docker Container](https://github.com/JetBrains/projector-docker) locally, follow the instructions in section [Run IntelliJ IDEA in Docker (building image yourself)](https://github.com/JetBrains/projector-docker#run-intellij-idea-in-docker-building-image-yourself)

```ad-important
If you are running on an Apple Silicon based mac, then you must specify the intel architecture for building the docker image. Thus, do not use the scripts

- `build-container.sh` and
- `run-container.sh`

Instead, execute the following commands:
```

```shell
# Build the container for the intel platform:
DOCKER_BUILDKIT=1 docker build --progress=plain -t "projector-idea-c" --build-arg buildGradle=true --build-arg "downloadUrl=https://download.jetbrains.com/idea/ideaIC-2019.3.5.tar.gz" --platform amd64 -f Dockerfile ..

# Run the container for the intel platform
docker run --rm -p 8887:8887 -it "projector-idea-c"
```

See also:

- Docker: [Multi-platform images](https://docs.docker.com/build/building/multi-platform/)

```ad-important
Please check whether the following problem still applies with the `amd64` platform:
```

```ad-important
The following problem occurs when the container is built for the `arm64v8` platform:

The projector container does not contain a JDK. This will prevent projector from starting up. To fix, I am trying to install OpenJDK 17 following [these instructions](https://computingforgeeks.com/install-oracle-java-openjdk-on-debian-linux/).
```

## 2. Create a Google Artifact Registry and a Docker Repository

1. Create, a new project on [Cloud Console](https://console.cloud.google.com/) - name: YASCR (yascr-365610)
2. Select the project in Cloud Console
3. [Enable the Artifact Registry API](https://console.cloud.google.com/artifacts) for the project
4. Create a Docker Repository in the [Artifact Registry](https://console.cloud.google.com/artifacts/create-repo) - name: docker-repository

## 3. Deploy the Container To Google CloudRun

1. [Configure authentication](https://cloud.google.com/artifact-registry/docs/docker/authentication) (here EU West 1):

   ```shell
   gcloud auth configure-docker europe-west1-docker.pkg.dev
   ```

   If you would like to host in a different region, then find out available repository locations and adapt the call above.

   ```shell
   gcloud artifacts locations list
   ```

   Verify that the credential helper works:

   ```shell
   echo "europe-west1-docker.pkg.dev" | docker-credential-gcloud get
   ```

2. Tag the local image with the registry name:

   ```shell
   docker tag registry.jetbrains.team/p/prj/containers/projector-idea-c europe-west1-docker.pkg.dev/yascr-365610/docker-repository/projector-idea-c:latest
   ```

3. Push the projector image to your Docker Repository

   ```shell
   docker push europe-west1-docker.pkg.dev/yascr-365610/docker-repository/projector-idea-c:latest
   ```

4. Create a new service to run the image in [CloudRun](https://console.cloud.google.com/run)

   - Configuration: 8 GB memory, 2 vCPUs
   - You can configure to automatically start and stop the container on demand

## Alternatives to JetBrains Projector

- [Gregor Riegler: Remdev on Azure](https://github.com/gregorriegler/remdev-azure)
- [Cyber Dojo](http://www.cyber-dojo.org/)
