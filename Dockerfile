FROM eceasy/cli-proxy-api:latest@sha256:3e0f488896d2fd6d19309d6de1e99917ca4ebac74df2c5eedc7c946150fbf5f1

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
