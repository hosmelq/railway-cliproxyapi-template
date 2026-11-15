FROM eceasy/cli-proxy-api:latest@sha256:5727997d6407a7be54e58275d595ffeac0200eb388520b87bf2d2e1e042d9b5b

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
