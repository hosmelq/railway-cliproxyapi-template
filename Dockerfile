FROM eceasy/cli-proxy-api:latest@sha256:ce02dd2ba9186024762d8b6525c068c5a5fab78435b8d82d9c03f7ce74feeb5b

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
