FROM registry.jetbrains.team/p/prj/containers/projector-rider

USER root

RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get clean \
    && apt-get update \
    && apt-get install -y curl \
    && apt-get install -y dotnet-sdk-6.0

RUN curl -sL install.mob.sh | sh

RUN mkdir -p /home/projector-user/.ssh
RUN chown projector-user:projector-user /home/projector-user/.ssh

USER projector-user
COPY --chown=projector-user:projector-user ssh/id_yascr22 /home/projector-user/.ssh/
COPY --chown=projector-user:projector-user ssh/config /home/projector-user/.ssh/
COPY --chown=projector-user:projector-user ssh/known_hosts /home/projector-user/.ssh/
COPY --chown=projector-user:projector-user .bashrc /home/projector-user/
RUN chmod 0600 /home/projector-user/.ssh/id_yascr22

COPY --chown=projector-user:projector-user IdeaIC2019.3/config/options/recentProjects.xml /home/projector-user/.IdeaIC2019.3/config/options/recentProjects.xml  
COPY --chown=projector-user:projector-user IdeaIC2019.3/config/workspace/1YIGAPrg2L8B5jDSfYv4UolAdNP.xml /home/projector-user/.IdeaIC2019.3/config/workspace/1YIGAPrg2L8B5jDSfYv4UolAdNP.xml  

WORKDIR /home/projector-user/
RUN git clone git@github.com:small-coding-dojo/yascrtest.git
