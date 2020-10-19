FROM registry.nspop.dk/platform/nsp:1

# Skip access handler
RUN echo '.*' > /pack/wildfly8/modules/system/layers/base/dk/sds/nsp/accesshandler/main/handler.skip

# Declare local module used for configuration files
COPY ./etc/ /pack/wildfly8/modules/dk/sds/nsp/maternity/cfg/main/

# Copy the war file to the deployment directory
COPY target/*.war /pack/wildfly8/standalone/deployments/

# Eager initialization of servlet filters - used for OIOSAML
RUN sed -i s'/<servlet-container name="default">/<servlet-container name="default" eager-filter-initialization="true">/' /pack/wildfly8/standalone/configuration/standalone.xml

