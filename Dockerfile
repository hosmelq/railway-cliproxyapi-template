FROM eceasy/cli-proxy-api:latest@sha256:362e7ac699a0f2608d7c55f8f8cb764e5afbfe4ed22aadc26fcb147eecbf2a03

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
