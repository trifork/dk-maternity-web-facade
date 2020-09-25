FROM registry.nspop.dk/platform/nsp:1

# Default OIOSAML configuration folder, oiosaml.home will be pack/OIOSAML_CONFIG_FOLDER
ENV JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"

# Skip access handler
RUN echo '.*' > /pack/wildfly8/modules/system/layers/base/dk/sds/nsp/accesshandler/main/handler.skip

# Copy configuration files
#COPY etc/wildfly /pack/wildfly8/

# Copy the war file to the deployment directory
COPY target/*.war /pack/wildfly8/standalone/deployments/

RUN sed -i s'/<servlet-container name="default">/<servlet-container name="default" eager-filter-initialization="true">/' /pack/wildfly8/standalone/configuration/standalone.xml
RUN sed -i s'/<bean-validation enabled="true"\/>/<bean-validation enabled="false"\/>/' /pack/wildfly8/standalone/configuration/standalone.xml

