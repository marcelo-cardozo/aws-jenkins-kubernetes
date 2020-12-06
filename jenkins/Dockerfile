FROM jenkins/jenkins:lts

ARG HOST_UID=1001
ARG HOST_GID=998

# default user is "jenkins", to install new packages use the "root" user
USER root

RUN apt-get update
RUN apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
RUN apt-get install -y tidy
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

RUN usermod -u $HOST_UID jenkins
RUN groupmod -g $HOST_GID docker
RUN usermod -aG docker jenkins

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main">> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-get update
RUN apt-get install -y ansible

RUN apt install -y python3 python3-pip
RUN pip3 install ansible openshift
RUN ansible-galaxy collection install community.kubernetes

# install plugins
# check plugins in https://updates.jenkins.io/download/plugins/
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER jenkins

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml


# specify configuration for jenkins instance
COPY casc.yaml /var/jenkins_home/casc.yaml