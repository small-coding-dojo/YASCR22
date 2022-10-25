FROM registry.jetbrains.team/p/prj/containers/projector-idea-c

USER root
RUN apt-get clean
RUN apt-get update
RUN apt-get install sudo
RUN apt-get install -y curl
RUN curl -sL install.mob.sh | sh

USER projector-user
