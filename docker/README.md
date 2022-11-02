# Building the Docker Image

- Copy the id_yascr22 file to /docker/ssh

```shell
docker build -t "europe-west1-docker.pkg.dev/yascr-365610/docker-repository/projector-idea-c:latest" .
docker push europe-west1-docker.pkg.dev/yascr-365610/docker-repository/projector-idea-c:latest
```

