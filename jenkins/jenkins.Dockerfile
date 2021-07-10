FROM jenkins/jenkins:jdk11

# run as root
USER root
RUN apt-get update && apt-get install -y python3 python3-pip

# install awscli
RUN python3 -m pip install awscli

# install go
RUN curl https://dl.google.com/go/go1.16.1.linux-amd64.tar.gz -o go.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=$HOME/go
ENV GOBIN=$HOME/go/bin
ENV PATH=$PATH:$GOBIN
RUN go version

# install hugo
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v0.81.0/hugo_0.81.0_Linux-64bit.tar.gz -o hugo.tar.gz
RUN tar -C /usr/bin -xvf hugo.tar.gz
RUN hugo version

# install plugins
USER jenkins
# ARG PLUGINS_FORCE_UPGRADE=true
ENV PLUGINS_FORCE_UPGRADE=true
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt --latest

# Update Jenkins
# RUN curl -L https://get.jenkins.io/war/latest/jenkins.war -o jenkins.war
# COPY --chown=jenkins:jenkins jenkins.war /usr/share/jenkins/jenkins.war
