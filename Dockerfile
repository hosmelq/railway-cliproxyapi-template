FROM eceasy/cli-proxy-api:latest@sha256:fd49f56bfcfbfc424709e501f4f8c9ff6e28ff8d8d039eb75d28850201511879

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
