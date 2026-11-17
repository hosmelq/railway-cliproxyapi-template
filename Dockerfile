FROM eceasy/cli-proxy-api:latest@sha256:d205abff33a6381001223588e32052f45070ee7a4f1dc0c47e16644a8c82b4fb

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
