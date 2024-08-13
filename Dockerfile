FROM alpine:3.20

RUN apk upgrade --no-cache && \
    apk add --no-cache \
    python3=3.12.3-r1 \
    py3-boto3=1.34.108-r0 \
    py3-packaging=24.0-r1

COPY assets/ /opt/resource/
