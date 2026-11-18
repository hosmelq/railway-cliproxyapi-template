FROM eceasy/cli-proxy-api:latest@sha256:2acf44fbadf9933a04e971048b4c2ddd184ce6e3ea08fc2dc25354f3a365f5ab

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
