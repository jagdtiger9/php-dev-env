FROM voxxit/rsyslog

# Include all .conf files in /etc/rsyslog.d
ADD ./conf /etc/rsyslog.d/

COPY ./conf/logrotate-docker /etc/logrotate.d/docker
