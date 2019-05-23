#FROM jenkins/jenkins:2.121.3
FROM jenkins/jenkins:2.176 

USER root
# define env variables
ENV JENKINS_REF="/usr/share/jenkins/ref"

# define JVM options
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false \
              -Duser.timezone=Europe/London

# install jenkins plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# copy jenkins shared configuration
COPY ./ref $JENKINS_REF

COPY --chown=jenkins:jenkins  ./src /var/jenkins_home/src

WORKDIR /var/jenkins_home



USER jenkins