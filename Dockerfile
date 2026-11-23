FROM eceasy/cli-proxy-api:latest@sha256:e2f9c436ff992ef5830227ccc9fb67d40246bb1420708fbcd18e1de675e88c98

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
