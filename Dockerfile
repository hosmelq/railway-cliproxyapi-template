FROM eceasy/cli-proxy-api:latest@sha256:32fb7dfc272bf63daee4dcaaa679095aad431ceed31416f98ea55f3d1d7db77a

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
