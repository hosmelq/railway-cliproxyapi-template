FROM eceasy/cli-proxy-api:latest@sha256:e77c1eecc0e364c1885a4441cdd6487ef305852851f70da723548736065c2e9b

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
