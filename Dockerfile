FROM eceasy/cli-proxy-api:latest@sha256:37733f2a1eaa029e3915a37087b617f85535fe1b25534c8d2cb7f5152e23b02b

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
