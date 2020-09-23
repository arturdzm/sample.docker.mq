FROM websphere-liberty

COPY --chown=1001:0 server.xml /config
COPY --chown=1001:0 sender.war /config/dropins/
COPY --chown=1001:0 wmq.jmsra-9.2.0.0.rar /config/wmq/

RUN installUtility install --acceptLicense defaultServer \
    configure.sh