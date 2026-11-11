FROM eceasy/cli-proxy-api:latest@sha256:2e098c0b3c79571f0c3150c8f27725ab2645b6a463cf6c4f862e4e86343466a1

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
