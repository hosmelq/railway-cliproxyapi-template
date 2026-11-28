FROM eceasy/cli-proxy-api:latest@sha256:29717a242f16aa12256b36a2d86f5ac7bbfe2dd002f23ce66eeb27fddbc096c0

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
