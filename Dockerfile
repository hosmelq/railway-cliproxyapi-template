FROM eceasy/cli-proxy-api:latest@sha256:098ee6aaadf399f1812f3bba959c593182e3a44f5f1d28a8ec44b8c827ebd942

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
