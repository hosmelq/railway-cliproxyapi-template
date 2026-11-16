FROM eceasy/cli-proxy-api:latest@sha256:16bdaaf25b86cd1974ec9bfcc2253a44ac6510ea22f7a483b36f8dee13b003c2

ENV PORT=8317

COPY config.initial.yaml /opt/railway/config.initial.yaml
COPY --chmod=755 start.sh /opt/railway/start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/railway/start.sh"]
