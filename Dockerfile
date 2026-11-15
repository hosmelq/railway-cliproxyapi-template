FROM eceasy/cli-proxy-api:latest@sha256:7cac48fd7f3ac0b7b6b73508d92179e29454087d9af81eb9a5c9fb50cdd87bc8

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
