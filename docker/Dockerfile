FROM registry.jetbrains.team/p/prj/containers/projector-idea-c

USER root
RUN apt-get clean
RUN apt-get update
RUN apt-get install sudo
RUN apt-get install -y curl
RUN curl -sL install.mob.sh | sh

RUN mkdir -p /home/projector-user/.ssh
RUN chown projector-user:projector-user /home/projector-user/.ssh

USER projector-user
COPY --chown=projector-user:projector-user ssh/id_yascr22 /home/projector-user/.ssh/
COPY --chown=projector-user:projector-user ssh/config /home/projector-user/.ssh/
COPY --chown=projector-user:projector-user ssh/known_hosts /home/projector-user/.ssh/
COPY --chown=projector-user:projector-user .bashrc /home/projector-user/
RUN chmod 0600 /home/projector-user/.ssh/id_yascr22
