# dockerfile-docker-with-jboss
Dockerfile for docker with jboss on jdk 8

This dockerfile an extension from https://hub.docker.com/r/fabric8/java-jboss-openjdk8-jdk/ .
It uses the base image `docker`, so that java application that want to interract with the host docker can easily run in a container.

Example usage: 
```
FROM stakater/docker-with-jboss

ENV JAVA_APP_JAR /ROOT.war

ADD myapp.war /ROOT.war

EXPOSE 8080
```