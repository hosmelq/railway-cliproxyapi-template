FROM eceasy/cli-proxy-api:latest@sha256:9ee2d80894763f712071e89adfe3b7e56458a3f600bb9fb9688ffeb067618e26

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
