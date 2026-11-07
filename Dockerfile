FROM eceasy/cli-proxy-api:latest@sha256:40dda818164c1012154e18999d35d9cf14d936bd74eabdd62e22284e8898d50d

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
