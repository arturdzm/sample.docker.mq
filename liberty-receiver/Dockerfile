FROM websphere-liberty

COPY --chown=1001:0 server.xml /config/
COPY --chown=1001:0 receiver.war /config/dropins/
COPY --chown=1001:0 wmq.jmsra-9.2.0.0.rar /config/wmq/
COPY --chown=1001:0 connection_info_ccdt.json /etc/mq/

RUN installUtility install --acceptLicense defaultServer \
    configure.sh