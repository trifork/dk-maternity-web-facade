FROM registry.nspop.dk/platform/nsp:3.0.0-wildfly21.rc3

# Skip access handler
RUN echo '.*' > /pack/wildfly/modules/system/layers/base/dk/sds/nsp/accesshandler/main/handler.skip

# Declare local module used for configuration files
COPY ./etc/module.xml /pack/wildfly/modules/dk/sds/nsp/maternity/cfg/main/


# Copy the war file to the deployment directory
COPY target/*.war /pack/wildfly/standalone/deployments/

# Eager initialization of servlet filters - used for OIOSAML
RUN sed -i s'/<servlet-container name="default">/<servlet-container name="default" eager-filter-initialization="true">/' /pack/wildfly/standalone/configuration/standalone.xml

