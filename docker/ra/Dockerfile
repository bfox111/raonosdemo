FROM cyan/raonosdemo-base

RUN mkdir -p /bp2/log

WORKDIR /bp2/src/

EXPOSE 8080

ENV RASDK_SETTINGS_MODULE=raonosdemo.settings \
    NBI_ra_port=8080 \
    NBI_ra_publish=True \
    NBI_raonosdemo_port=8080 \
    NBI_raonosdemo_publish=True \
    SBIS=rabbitmq,statsd

RUN ln -s /usr/local/bin/rasdk-southbound-update /usr/local/bin/southbound-update

CMD ["raonosdemo", "--configpath", "/dev/shm", "--logfile", "/bp2/log/raonosdemo.log"]
