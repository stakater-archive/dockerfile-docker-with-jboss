FROM docker:17.10

# Install packages necessary to run EAP
RUN apk -Uuv add shadow xmlstarlet augeas libarchive-tools unzip openjdk8 curl bash

RUN mkdir -p /deployments

# JAVA_APP_DIR is used by run-java.sh for finding the binaries
ENV JAVA_APP_DIR=/deployments

# Agent bond including Jolokia and jmx_exporter
ADD agent-bond-opts /opt/run-java-options
RUN mkdir -p /opt/agent-bond \
 && curl http://central.maven.org/maven2/io/fabric8/agent-bond-agent/1.0.2/agent-bond-agent-1.0.2.jar \
          -o /opt/agent-bond/agent-bond.jar \
 && chmod 444 /opt/agent-bond/agent-bond.jar \
 && chmod 755 /opt/run-java-options
ADD jmx_exporter_config.yml /opt/agent-bond/

# Add run script as /deployments/run-java.sh and make it executable
COPY run-java.sh debug-options container-limits java-default-options /deployments/
RUN chmod 755 /deployments/run-java.sh /deployments/java-default-options /deployments/container-limits /deployments/debug-options

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java

EXPOSE 8778 9779
CMD [ "/deployments/run-java.sh" ]