FROM eceasy/cli-proxy-api:latest@sha256:0695ae8721d623ed31179369fc7127d469f10a14a37a49c366e82a16383662f8

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
