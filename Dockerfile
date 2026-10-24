FROM eceasy/cli-proxy-api:latest@sha256:b0fe699ae1aea9e8bb7c0525080f702957b96f178a686bd45d0bd749bf3cd156

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
