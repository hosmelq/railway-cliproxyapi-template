FROM eceasy/cli-proxy-api:latest@sha256:fd47aafcc896b23c23d655caca8bb3ffc0a68e3bd3db77e15b0c8b406f1a029b

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
